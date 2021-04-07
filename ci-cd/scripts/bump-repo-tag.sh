#!/bin/bash

docker pull scriptedatom/ssa-git-tagger-atom:latest
docker run --rm \
  -e BUMP_TYPE="$BUMP_TYPE" \
  -e REPO_URI="$REPO_URI" \
  -e REPO_USER="$REPO_USER" \
  -e REPO_TOKEN="$REPO_TOKEN" \
  scriptedatom/ssa-git-tagger-atom:latest