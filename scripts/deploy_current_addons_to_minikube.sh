#!/usr/bin/env bash
set -e
set -o pipefail

# This script allows you to use addons stored locally in Helm Broker.
# Following steps are performed:
# - build tar.gz files from ./addons directory and store them in ./out directory
# - copy index.yaml to ./out directory
# build image with nginx + targz + index.yaml
# apply deployment, service
# configure helm-broker to use new service


function buildTarGzInOutDir() {
    echo "Build targz files and store them in 'out' directory"
    docker run -it -v  ${ADDONS_REPO}:/workspace -w /workspace alpine:latest ./bin/targz ./addons ./out
}

function buildImageNginxWithAddons() {
    echo "Build image: nginx + targzs + index.yaml"
    echo "FROM nginx
    EXPOSE 80
    COPY . /usr/share/nginx/html
    " > ./out/Dockerfile

    eval $(minikube docker-env --shell=bash)

    cd ./out
    docker build -t addons-local .
    eval $(minikube docker-env --unset)
}

function removePreviousResources() {
    kubectl delete service -l app=addons-local --ignore-not-found=true --wait=true
    kubectl delete deployment addons-local --ignore-not-found=true --wait=true

}

function applyService() {
    echo "Apply k8s service"
cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: Service
    metadata:
      name: addons-local-${TS}
      labels:
        app: addons-local
    spec:
      type: "NodePort"
      ports:
        - name: "http"
          port: 80
          targetPort: 80
      selector:
        app: addons-local
EOF
}

function applyDeployment() {
    echo "Apply k8s deployment"
cat <<EOF | kubectl apply -f -
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: addons-local
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: addons-local
      template:
        metadata:
          annotations:
            sidecar.istio.io/inject: "false"
          labels:
            app: addons-local
        spec:
          containers:
          - image: addons-local:latest
            imagePullPolicy: Never
            name: addons-local
            env:
            - name: triggerRestart
              value: "${TS}"
            ports:
              - containerPort: 80
EOF
}

function disableMTLS() {
    echo "Apply istio DestinationRule to disable mTLS for 'addons-local' "
cat <<EOF | kubectl apply -f -
    apiVersion: networking.istio.io/v1alpha3
    kind: DestinationRule
    metadata:
      name: "addons-local"
    spec:
      host: "addons-local-${TS}.default.svc.cluster.local"
      trafficPolicy:
        tls:
          mode: DISABLE
EOF
}


function configureURLInHelmBroker() {
    echo "Configure Helm-Broker to use 'addons-local'"
cat <<EOF | kubectl apply -f -
    apiVersion: addons.kyma-project.io/v1alpha1
    spec:
      repositories:
      - url: http://addons-local-${TS}.default.svc.cluster.local
    kind: ClusterAddonsConfiguration
    metadata:
      labels:
        app: helm-broker
        helm-broker-repo: "true"
        triggerUpdate: "${TS}"
      name: helm-repos-urls
      namespace: kyma-system
EOF
}

function waitForServiceToBeAvailable() {
    pod=$(kubectl get pods -n kyma-system -l app=helm-broker -ocustom-columns=name:.metadata.name --no-headers=true)
    echo "Running on pod ${pod}"

    cmd="set +e
    url=\"http://addons-local-${TS}.default.svc.cluster.local\"
    echo \"\${url}\"
    while true
    do
      response=\$(curl --write-out %{http_code} --silent --output /dev/null \${url}/index.yaml)
      echo \"Got response from addons-local service: \${response}\"
      if [[ \"\${response}\" -ne 200 ]] ; then
        echo \"Sleep for 3 seconds...\"
        sleep 3
      else
        echo \"Service is available\"
        break
      fi
    done"

    kubectl exec -it -n kyma-system $pod -c broker -- /bin/sh -c "$cmd"
}


export ROOT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export ADDONS_REPO=$( cd "${ROOT_PATH}/.."  && pwd)

rm -rf ${ADDONS_REPO}/out
mkdir ${ADDONS_REPO}/out

cd ${ADDONS_REPO}
export TS=$(date +%s)
echo "Generated unique suffix for service: ${TS}"
removePreviousResources
buildTarGzInOutDir
cp ./addons/index.yaml ./out
buildImageNginxWithAddons
applyService
applyDeployment
disableMTLS
waitForServiceToBeAvailable
configureURLInHelmBroker

echo "SUCCESS!!!"