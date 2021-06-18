#!/bin/bash

IMG_TAGS+=("<none>")
if [[ $CI_COMMIT_REF_NAME != "major-release" && $CI_COMMIT_REF_NAME != "minor-release" && $CI_COMMIT_REF_NAME != "master" ]]; then
  IMG_TAGS+=("$CI_COMMIT_REF_NAME")
else
  IMG_TAGS+=("$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')")
fi

for IMG_TAG in ${IMG_TAGS}; do
  echo "Deleting the following images : \
    $(docker images |
    grep -E '^(registry\.gitlab\.com\/piximos)|(scriptedatom\/)' |
    awk 'NR>1 {img_name=sprintf("%s:%s",$1,$2); print img_name}' |
    grep "scripted" |
    grep "atom" |
    grep "$IMG_TAG")"
  docker images |
    grep -E '^(registry\.gitlab\.com\/)?piximos' |
    awk 'NR>1 {img_name=sprintf("%s:%s",$1,$2); print img_name}' |
    grep "scripted" |
    grep "atom" |
    grep "$IMG_TAG" |
    xargs docker rmi 2> /dev/null || exit 0
done
