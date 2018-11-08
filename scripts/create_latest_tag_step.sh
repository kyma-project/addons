#!/usr/bin/env bash

GIT_URL=$1

git config --global user.email "builds@travis-ci.com"
git config --global user.name "Travis CI"
export GIT_TAG=latest
git tag $GIT_TAG -f -a -m "Generated tag from TravisCI"
git push ${GIT_URL} $GIT_TAG -f