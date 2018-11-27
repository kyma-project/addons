#!/usr/bin/env bash

GIT_REPO=$1

echo "Getting latest release from $GIT_REPO"
RESP=$(curl -s "https://api.github.com/repos/$GIT_REPO/releases/latest?access_token=${GITHUB_TOKEN}")
URLS=$(echo "$RESP" | grep url | cut -d '{' -f1 | cut -d '"' -f4)
RELEASE_URL=(${URLS// / })

echo "Deleting old latest release"
RESPONSE=$(curl -s -X DELETE "${RELEASE_URL}?access_token=${GITHUB_TOKEN}")
echo ${RESPONSE}
