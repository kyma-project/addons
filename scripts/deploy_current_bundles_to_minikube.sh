#!/usr/bin/env bash
set -e
set -o pipefail

# This script allows you to use bundles stored locally in Helm Broker.
# Following steps are performed:
# - build tar.gz files from ./bundles directory and store them in ./out directory
# - copy index.yaml to ./out directory
# build image with nginx + targz + index.yaml
# apply deployment, service
# configure helm-broker to use new service


function buildTarGzInOutDir() {
    echo "Build targz files and store them in 'out' directory"
    docker run -it -v  ${BUNDLES_REPO}:/workspace -w /workspace alpine:latest ./bin/targz ./bundles ./out
}

function buildImageNginxWithBundles() {
    echo "Build image: nginx + targzs + index.yaml"
    echo "FROM nginx
    EXPOSE 80
    COPY . /usr/share/nginx/html
    " > ./out/Dockerfile

    eval $(minikube docker-env --shell=bash)

    cd ./out
    docker build -t bundles-local .
    eval $(minikube docker-env --unset)
}

function removePreviousResources() {
    kubectl delete service -l app=bundles-local --ignore-not-found=true --wait=true
    kubectl delete deployment bundles-local --ignore-not-found=true --wait=true

}

function applyService() {
    echo "Apply k8s service"
cat <<EOF | kubectl apply -f -
    apiVersion: v1
    kind: Service
    metadata:
      name: bundles-local-${TS}
      labels:
        app: bundles-local
    spec:
      type: "NodePort"
      ports:
        - name: "http"
          port: 80
          targetPort: 80
      selector:
        app: bundles-local
EOF
}

function applyDeployment() {
    echo "Apply k8s deployment"
cat <<EOF | kubectl apply -f -
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: bundles-local
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: bundles-local
      template:
        metadata:
          annotations:
            sidecar.istio.io/inject: "false"
          labels:
            app: bundles-local
        spec:
          containers:
          - image: bundles-local:latest
            imagePullPolicy: Never
            name: bundles-local
            env:
            - name: triggerRestart
              value: "${TS}"
            ports:
              - containerPort: 80
EOF
}

function disableMTLS() {
    echo "Apply istio DestinationRule to disable mTLS for 'bundles-local' "
cat <<EOF | kubectl apply -f -
    apiVersion: networking.istio.io/v1alpha3
    kind: DestinationRule
    metadata:
      name: "bundles-local"
    spec:
      host: "bundles-local-${TS}.default.svc.cluster.local"
      trafficPolicy:
        tls:
          mode: DISABLE
EOF
}


function configureURLInHelmBroker() {
    echo "Configure Helm-Broker to use 'bundles-local'"
cat <<EOF | kubectl apply -f -
    apiVersion: v1
    data:
      URLs: http://bundles-local-${TS}.default.svc.cluster.local
    kind: ConfigMap
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
    url=\"http://bundles-local-${TS}.default.svc.cluster.local\"
    echo \"\${url}\"
    while true
    do
      response=\$(curl --write-out %{http_code} --silent --output /dev/null \${url}/index.yaml)
      echo \"Got response from bundles-local service: \${response}\"
      if [[ \"\${response}\" -ne 200 ]] ; then
        echo \"Sleep for 3 seconds...\"
        sleep 3
      else
        echo \"Service is available\"
        break
      fi
    done"

     kubectl exec -it -n kyma-system $pod -c helm-broker -- /bin/sh -c "$cmd"
}


export ROOT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
export BUNDLES_REPO=$( cd "${ROOT_PATH}/.."  && pwd)

rm -rf ${BUNDLES_REPO}/out
mkdir ${BUNDLES_REPO}/out

cd ${BUNDLES_REPO}
export TS=$(date +%s)
echo "Generated unique suffix for service: ${TS}"
removePreviousResources
buildTarGzInOutDir
cp ./bundles/index.yaml ./out
buildImageNginxWithBundles
applyService
applyDeployment
disableMTLS
waitForServiceToBeAvailable
configureURLInHelmBroker

echo "SUCCESS!!!"