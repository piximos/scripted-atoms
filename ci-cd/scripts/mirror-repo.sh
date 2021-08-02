#!/bin/bash

docker pull scriptedatom/git-mirror:latest
docker run --rm \
  -e ORIGIN_REPO_URI="$CURRENT_REPO_URI" \
  -e ORIGIN_REPO_USER="$CURRENT_REPO_USER" \
  -e ORIGIN_REPO_TOKEN="$CURRENT_REPO_TOKEN" \
  -e REMOTE_REPO_URI="$REMOTE_REPO_URI" \
  -e REMOTE_REPO_USER="$REMOTE_REPO_USER" \
  -e REMOTE_REPO_TOKEN="$REMOTE_REPO_TOKEN" \
  scriptedatom/git-mirror:latest