#!/usr/bin/env bash
set -e

RELEASE_CHANGELOG_PATH="./.changelog/release-changelog.md"
DEST_CHANGELOG_FILE_PATH="addons/CHANGELOG.md"

echo "Copy release changelog to addons dir..."
cp $RELEASE_CHANGELOG_PATH $DEST_CHANGELOG_FILE_PATH
