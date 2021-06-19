#!/bin/bash

docker pull scriptedatom/ssa-git-yaml-file-version-bumper:latest
docker run --rm \
  -e VERSION_FILE="$VERSION_FILE" \
  -e VERSION_PATH="$VERSION_PATH" \
  -e VERSION_BUMP_MESSAGE_PREFIX="$VERSION_BUMP_MESSAGE_PREFIX" \
  -e REPO_BRANCH="$REPO_BRANCH" \
  -e REPO_URI="$REPO_URI" \
  -e REPO_USER="$REPO_USER" \
  -e REPO_TOKEN="$REPO_TOKEN" \
  scriptedatom/ssa-git-yaml-file-version-bumper:latest