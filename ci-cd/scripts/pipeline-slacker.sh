#!/bin/bash

if [[ $CI_COMMIT_REF_NAME != "major-release" && $CI_COMMIT_REF_NAME != "minor-release" && $CI_COMMIT_REF_NAME != "master" ]]; then
  IMG_TAGS=("$CI_COMMIT_REF_NAME$IMG_COMPLEMENTARY_TAG")
elif [[ $CI_COMMIT_REF_NAME = "master" ]]; then
  IMG_TAGS=("latest$IMG_COMPLEMENTARY_TAG" "$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')$IMG_COMPLEMENTARY_TAG")
else
  IMG_TAGS=("$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')$IMG_COMPLEMENTARY_TAG")
fi

SLACK_MSG="Deployed the following tags : $(IFS=,; echo "${IMG_TAGS[*]}")"

docker pull scriptedatom/ssa-pipeline-slacker-atom:latest
docker run --rm \
  -e SLACK_WEBHOOK_URL="$SLACK_WEBHOOK_URL" \
  -e SLACK_MSG="$SLACK_MSG" \
  scriptedatom/ssa-pipeline-slacker-atom:latest