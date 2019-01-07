#!/usr/bin/env bash
set -e

GIT_TAG=$1
GIT_REPO=$2

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUNDLES_PATH="${CURRENT_DIR}/.."

# pull changelog generator image
docker pull eu.gcr.io/kyma-project/changelog-generator:0.2.0;

# remove 'latest' tag before generate changelog
git tag -d latest;

# find tag one before last
PENULTIMATE=$(./scripts/from_tag.sh ${GIT_TAG});

# generate release changelog
docker run --rm -v ${BUNDLES_PATH}:/repository -w /repository -e FROM_TAG=${PENULTIMATE} -e TO_TAG=${GIT_TAG} -e NEW_RELEASE_TITLE=${GIT_TAG} -e GITHUB_AUTH=${GITHUB_TOKEN} -e CONFIG_FILE=scripts/package.json -e SKIP_REMOVING_LATEST=true eu.gcr.io/kyma-project/changelog-generator:0.2.0 sh /app/generate-release-changelog.sh;

# move release changelog to release directory
./scripts/move_changelog.sh;

# restore latest tag
git tag latest;
