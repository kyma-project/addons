#!/usr/bin/env bash

set -o errexit # exit immediately if a command exits with a non-zero status.
set -o nounset # exit when script tries to use undeclared variables

readonly RED='\033[0;31m'
readonly NC='\033[0m' # No Color

function downloadTargz() {
    echo "Installing targz tool"
    go get -u "github.com/kyma-project/kyma/components/helm-broker/cmd/targz"
    if [ $? -ne 0 ]
    then
        echo -e "${RED}Cannot install targz tool${NC}"
        exit 1
    fi
}


function convertBundlesToTargz() {
          destination=toCopy/

          echo "Copy files"

          mkdir -p toCopy
          cp README.md ${destination}
          cp index.yaml ${destination}

          echo "Executing targz"
          targz bundles/ ${destination}

          echo "Processing done"
          echo
}

downloadTargz
convertBundlesToTargz