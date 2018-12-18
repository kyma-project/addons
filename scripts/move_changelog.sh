#!/usr/bin/env bash
set -e

RELEASE_CHANGELOG_PATH="./.changelog/release-changelog.md"
DEST_CHANGELOG_FILE_PATH="bundles/CHANGELOG.md"

echo "Copy release changelog to bundles dir..."
cp $RELEASE_CHANGELOG_PATH $DEST_CHANGELOG_FILE_PATH
