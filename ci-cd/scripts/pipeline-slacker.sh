#!/bin/bash

if [[ $CI_COMMIT_REF_NAME != "major-release" && $CI_COMMIT_REF_NAME != "minor-release" && $CI_COMMIT_REF_NAME != "master" ]]; then
  IMG_TAGS=("$CI_COMMIT_REF_NAME$IMG_COMPLEMENTARY_TAG")
elif [[ $CI_COMMIT_REF_NAME == "master" ]]; then
  IMG_TAGS=("latest$IMG_COMPLEMENTARY_TAG" "$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')$IMG_COMPLEMENTARY_TAG")
else
  IMG_TAGS=("$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')$IMG_COMPLEMENTARY_TAG")
fi

#IMAGES=("scriptedatom/saa-base"
#  "scriptedatom/sta-base"
#  "scriptedatom/ssa-base"
#  "scriptedatom/saa-qr-code-generator-s3"
#  "scriptedatom/saa-qr-code-generator-fs"
#  "scriptedatom/saa-otp-maker"
#  "scriptedatom/saa-s3-unzipper"
#  "scriptedatom/saa-thumbnail-generator"
#  "scriptedatom/ssa-s3-file-backup-atom"
#  "scriptedatom/ssa-git-tagger-atom"
#  "scriptedatom/ssa-git-mirror-atom"
#  "scriptedatom/ssa-pipeline-slacker-atom"
#  "scriptedatom/sta-s3-file-sync"
#  "scriptedatom/sta-uptime-tracker")

deployed_tags=""
for img in "${IMAGES[@]}"; do
  for tag in "${IMG_TAGS[@]}"; do
    deployed_tags="scriptedatom/$deployed_tags\\n- $img:*$tag*"
  done
done

SLACK_MSG="Deployed the following tags : $deployed_tags"

docker pull scriptedatom/ssa-pipeline-slacker-atom:latest
docker run --rm \
  -e SLACK_WEBHOOK_URL="$SLACK_WEBHOOK_URL" \
  -e SLACK_MSG="$SLACK_MSG" \
  scriptedatom/ssa-pipeline-slacker-atom:latest
