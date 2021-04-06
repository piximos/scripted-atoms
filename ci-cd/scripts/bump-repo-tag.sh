#!/bin/bash

docker pull docker pull piximos/scripted-simple-atom-git-tagger-atom:latest
docker run --rm \
  -e BUMP_TYPE="$BUMP_TYPE" \
  -e REPO_URI="$REPO_URI" \
  -e REPO_USER="$REPO_USER" \
  -e REPO_TOKEN="$REPO_TOKEN" \
  docker pull piximos/scripted-simple-atom-git-tagger-atom:latest