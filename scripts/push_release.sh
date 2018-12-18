#!/usr/bin/env bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Some parameters [GIT_TAG, GIT_REPO] were not provided"
    exit
fi

GIT_TAG=$1
GIT_REPO=$2

CREATE_RELEASE_DATA='{
  "tag_name": "'"${GIT_TAG}"'",
  "target_commitish": "master",
  "name": "'"${GIT_TAG}"'",
  "body": "release-'"${GIT_TAG}"'",
  "draft": false,
  "prerelease": false
  }'

echo "Creating a new release: $GIT_TAG branch: master"

RESPONSE=$(curl -s --data "${CREATE_RELEASE_DATA}" "https://api.github.com/repos/$GIT_REPO/releases?access_token=${GITHUB_TOKEN}")
ASSET_UPLOAD_URL=$(echo "$RESPONSE" | jq -r .upload_url | cut -d '{' -f1)
if [ -z "$ASSET_UPLOAD_URL" ]; then
    echo ${RESPONSE}
    exit 1
fi

for FILE in toCopy/*; do
    echo "Uploading asset: $FILE to url: $ASSET_UPLOAD_URL?name=${FILE}"
    curl -s --data-binary @${FILE} -H "Content-Type: application/octet-stream" -X POST "$ASSET_UPLOAD_URL?name=$(basename ${FILE})&access_token=${GITHUB_TOKEN}"
done