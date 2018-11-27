#!/usr/bin/env bash

GIT_TAG=$1
GIT_REPO=$2
BRANCH=$(git rev-parse --abbrev-ref HEAD)

git checkout -f master
git add CHANGELOG.md
git commit -m "Update CHANGELOG.md for version ${GIT_TAG}"
git push -f https://${GITHUB_TOKEN}@github.com/${GIT_REPO}
git checkout ${BRANCH}
