#!/bin/bash

set -x # echo on

if [[ $CI_COMMIT_REF_NAME != "master" ]]; then
  IMG_TAGS=("$CI_COMMIT_REF_NAME")
else
  IMG_TAGS=("latest" "$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')")
fi

for IMG_TAG in "${IMG_TAGS[@]}"; do
  docker images \
  | grep -E '^(registry\.gitlab\.com\/)?piximos' \
  | grep "scripted" \
  | grep "atom" \
  | grep "$IMG_TAG" \
  | 'NR>1 {img_name=sprintf("%s:%s",$1,$2); print img_name}' \
  | xargs docker rmi
done
