#!/usr/bin/env bash

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
echo ${RESPONSE}

ASSET_UPLOAD_URL=$(echo "$RESPONSE" | grep upload_url | cut -d '{' -f1 | cut -d '"' -f4)
if [ -z "$ASSET_UPLOAD_URL" ]; then
    exit
fi

for FILE in toCopy/*; do
    echo "Uploading asset: $FILE to url: $ASSET_UPLOAD_URL?name=${FILE}"
    curl -s --data-binary @${FILE} -H "Content-Type: application/octet-stream" -X POST "$ASSET_UPLOAD_URL?name=$(basename ${FILE})&access_token=${GITHUB_TOKEN}"
done