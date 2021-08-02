#!/usr/bin/env bash
set -e

GIT_REPO=$1

echo "Getting latest release from $GIT_REPO"
RESP=$(curl -s -H "Authorization: token ${GITHUB_TOKEN}" "https://api.github.com/repos/$GIT_REPO/releases/latest")
URLS=$(echo "$RESP" | jq -r .url)
if [ -z "${URLS}" ]; then
    echo ${RESP}
    exit 1
fi
RELEASE_URL=(${URLS// / })

echo "Deleting old latest release"
RESPONSE=$(curl -s -X DELETE -H "Authorization: token ${GITHUB_TOKEN}" "${RELEASE_URL}")
echo ${RESPONSE}
