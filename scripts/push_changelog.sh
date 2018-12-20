#!/usr/bin/env bash
set -e

GIT_TAG=$1
GIT_REPO=$2
BRANCH=$(git rev-parse --abbrev-ref HEAD)
PUSH_BRANCH=master

git remote add origin https://github.com/${GIT_REPO}.git
git fetch origin ${PUSH_BRANCH}

# https://stackoverflow.com/questions/31576931/how-to-avoid-detached-headstate-in-git
git checkout -b temp
git branch -f ${PUSH_BRANCH} temp
git checkout -B ${PUSH_BRANCH} heads/${PUSH_BRANCH}

git add CHANGELOG.md
git commit -m "Update CHANGELOG.md for version ${GIT_TAG}"
git push -f https://${GITHUB_TOKEN}@github.com/${GIT_REPO} ${PUSH_BRANCH}
