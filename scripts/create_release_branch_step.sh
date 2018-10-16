#!/usr/bin/env bash

MAJOR=$(echo ${1} | cut -d. -f1)
MINOR=$(echo ${1} | cut -d. -f2)
REVISION=$(echo ${1} | cut -d. -f3)

GIT_URL=$2

if [[ ${REVISION} -eq 0 ]]; then
  GIT_BRANCH=release-${MAJOR}.${MINOR}
  echo "Creating branch ${GIT_BRANCH}"
  git checkout -b ${GIT_BRANCH}
  git push ${GIT_URL}
fi