#!/usr/bin/env bash

set -o errexit # exit immediately if a command exits with a non-zero status.

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly INVERTED='\033[7m'
readonly NC='\033[0m' # No Color

# DEFAULTS
silence="1> /dev/null"
helmLint=false
directories=()
helmVersion=latest


function show_help() {
    echo " Bundle checking tool"
    echo " Usage:"
    echo "   checker.sh [flags]"
    echo
    echo " Flags:"
    echo "    -h --help         helm for the script"
    echo "    --helm-lint       set to perform helm lint operation"
    echo "    --directories     specifies the list of bundle repository separated by ;"
    echo "    --helm-version    specifies the Helm version. Default set to `latest`."
    echo
    echo " Example of usage:"
    echo " checker.sh --helm-lint --directories ./bundles/showcase;./bundles/stable --helm-version v2.10.0"
}


POSITIONAL=()
while [[ $# -gt 0 ]]
do
    key="$1"

    case ${key} in
        -h|-\?|--help)
            show_help
            exit 0
            ;;
        --helm-lint)
            helmLint=true
            shift
            ;;
        --directories)
            directories=(${2//;/ })
            shift
            shift
            ;;
        --helm-version)
            helmVersion="$2"
            shift
            shift
            ;;
        *)    # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift # past argument
            ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

function downloadChecker() {
    echo "Installing bundle checker"
    go get "github.com/kyma-project/kyma/components/helm-broker/cmd/checker"
    if [ $? -ne 0 ]
    then
        echo -e "${RED}Cannot install checker${NC}"
        exit 1
    fi
}

function checkBundles() {
    # Bundle check
    for directory in ${directories[@]}
    do
        echo -e "${INVERTED}Checking bundles in directory ${directory} ${NC}"
        for bundle in ${directory}/*/; do
            echo -e "${GREEN}"
                checker ${bundle}
            echo -e "${NC}"
            if [ $? -ne 0 ]
            then
                exit 1
            fi
        done
    done

}

function installHelm() {
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
    chmod 700 get_helm.sh

    ./get_helm.sh --version ${helmVersion}

    echo "Installed Helm [version $(helm version --client)]"

    rm ./get_helm.sh
}

function lintHelmChartsIfRequested() {
    if [ "$helmLint" = false ];
    then
        exit 0
    fi

    installHelm
    echo "Linting Helm Charts"
    for directory in ${directories[@]}
    do
        for bundle in ${directory}/*/; do
            for chart in ${bundle}chart/*/; do
                for plan in ${bundle}/plans/*/; do
                    if [ -e ${plan}values.yaml ]
                    then
                        helmCmd="helm lint ${chart} --values ${plan}values.yaml"
                    else
                        helmCmd="helm lint ${chart}"
                    fi
                    echo -e "\n${GREEN}Executing: ${helmCmd}${NC}"
                    eval "${helmCmd}"
                    if [ $? -eq 1 ];
                    then
                        echo -e "${RED}Could not perform helm lint ${chart} with plan ${plan}"
                        echo "Try to run command:"
                        echo "${helmCmd}"
                        echo -e "${NC}"
                        exit 1
                    fi
                done
            done
        done
    done
}

downloadChecker
checkBundles
lintHelmChartsIfRequested