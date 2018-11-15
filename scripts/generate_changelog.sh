#!/usr/bin/env bash

# pull changelog generator image
docker pull eu.gcr.io/kyma-project/changelog-generator:0.2.0;

# remove 'latest' tag before generate changelog
git tag -d latest;

# find tag one before last
PENULTIMATE=$(./scripts/from_tag.sh ${TRAVIS_TAG});

# generate release changelog
docker run --rm -v ${TRAVIS_BUILD_DIR}:/repository -w /repository -e FROM_TAG=${PENULTIMATE} -e TO_TAG=${TRAVIS_TAG} -e NEW_RELEASE_TITLE=${TRAVIS_TAG} -e GITHUB_AUTH=${GITHUB_TOKEN} -e CONFIG_FILE=scripts/package.json -e SKIP_REMOVING_LATEST=true eu.gcr.io/kyma-project/changelog-generator:0.2.0 sh /app/generate-release-changelog.sh;

# move release changelog to release directory
./scripts/move_changelog.sh;

# generate full changelog
docker run --rm -v ${TRAVIS_BUILD_DIR}:/repository -w /repository -e NEW_RELEASE_TITLE=${TRAVIS_TAG} -e GITHUB_AUTH=${GITHUB_TOKEN} -e CONFIG_FILE=scripts/package.json -e SKIP_REMOVING_LATEST=true eu.gcr.io/kyma-project/changelog-generator:0.2.0 sh /app/generate-full-changelog.sh;

# restore latest tag
git tag latest;

# push full changelog to master branch
./scripts/push_changelog.sh;