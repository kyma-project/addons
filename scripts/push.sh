#!/usr/bin/env bash

git checkout -b master
git add CHANGELOG.md
git commit -m "Update CHANGELOG.md for version ${TRAVIS_TAG}"
git push https://${GITHUB_TOKEN}@github.com/${TRAVIS_REPO_SLUG}
