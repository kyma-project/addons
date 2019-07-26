#!/usr/bin/env bash

readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly INVERTED='\033[7m'
readonly BOLD='\033[1m'
readonly NC='\033[0m' # No Color

# DEFAULTS
helmLint=false
directories=()
helmVersion=latest
exitImmediatelyIfErr="set -e"
doNotExitImmediatelyIfErr="set +e"

function show_help() {
    echo " Addon checking tool"
    echo " Usage:"
    echo "   checker.sh [flags]"
    echo
    echo " Flags:"
    echo "    -h --help         helm for the script"
    echo "    --helm-lint       set to perform helm lint operation"
    echo "    --directories     specify the list of addon repository separated by ;"
    echo "    --helm-version    specify the Helm version. Default set to latest."
    echo
    echo " Example of usage:"
    echo " checker.sh --helm-lint --directories ./addons/showcase;./addons/stable --helm-version v2.10.0"
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

function validateInputParams() {
    if [ ${#directories[@]} -eq 0 ]; then
        echo -e "\n\t--directories parameter is required\n"

        show_help
        exit 1
    fi
}

function executeCmd() {
    local cmd=$1
    local exitErr=0

    echo -e "\n${BOLD}Executing: ${cmd}${NC}"
    local OUT_COLOR=${GREEN}

    # To prevent getting lost of new line characters, see: https://unix.stackexchange.com/a/164548
    IFS=
    out=$(eval "${cmd}")
    if [ $? -eq 1 ];
    then
        OUT_COLOR=${RED}
        exitErr=1
    fi

    echo -e "${OUT_COLOR}"
    echo ${out}
    echo -e "${NC}"

    return ${exitErr}
}

function checkAddons() {
    local errOccurred=0

    for directory in ${directories[@]}
    do
        echo -e "${INVERTED}Checking addons in directory ${directory}${NC}"
        for addon in ${directory}/*/; do
            executeCmd "bin/checker ${addon}"
            if [ $? -eq 1 ];
            then
                errOccurred=1
            fi
        done
    done

    if [ ${errOccurred} -eq 1 ];
    then
        exit 1
    fi
}

function installHelm() {
    echo -e "${INVERTED}Installing Helm...\n${NC}"
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
    chmod 700 get_helm.sh

    ./get_helm.sh --version ${helmVersion}

    echo -e "\n${GREEN}Installed Helm [version $(helm version --client)]${NC}\n"

    rm ./get_helm.sh
}

function lintHelmChartsIfRequested() {
    if [ "$helmLint" = false ];
    then
        exit 0
    fi

    eval ${exitImmediatelyIfErr}
        installHelm
    eval ${doNotExitImmediatelyIfErr}

    local errOccurred=0
    echo -e "${INVERTED}Linting Helm Charts...${NC}"
    for directory in ${directories[@]}
    do
        for addon in ${directory}/*/; do
            for chart in ${addon}chart/*/; do
                for plan in ${addon}/plans/*/; do
                    if [ -e ${plan}values.yaml ]
                    then
                        helmCmd="helm lint ${chart} --values ${plan}values.yaml"
                    else
                        helmCmd="helm lint ${chart}"
                    fi

                    executeCmd "${helmCmd}"
                    if [ $? -eq 1 ];
                    then
                        errOccurred=1
                    fi
                done
            done
        done
    done

    if [ ${errOccurred} -eq 1 ];
    then
        exit 1
    fi
}

validateInputParams

checkAddons
lintHelmChartsIfRequested