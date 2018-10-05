
#!/bin/bash

set -o errexit # exit immediately if a command exits with a non-zero status.
set -o nounset # exit when script tries to use undeclared variables

# iterate over repositories
for repoDir in bundles/*; do
  if [[ -d "${repoDir}" ]]; then

      name=`basename ${repoDir}`
      destination=toCopy/${name}

      echo "Processing ${name}"
      echo "Copy files"

      mkdir -p toCopy/${name}/repository
      cp ${repoDir}/README.md ${destination}
      cp ${repoDir}/index.yaml ${destination}

      echo "Helm-broker repository url: https://kyma-project.github.io/bundles/${name}/" > ${destination}/config.txt

      echo "Executing targz"
      ./scripts/targz ${repoDir} ${destination}

      echo "Processing ${name} done"
      echo
  fi;
done
