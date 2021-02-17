#!/bin/bash

MIRROR="false"
if [[ $CI_COMMIT_REF_NAME != "master" ]]; then
  IMG_TAGS=("$CI_COMMIT_REF_NAME")
else
  MIRROR="true"
  IMG_TAGS=("latest" "$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')")
fi

for IMG_TAG in "${IMG_TAGS[@]}"; do

  echo "Building image : ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
  docker build --cache-from "${DOCKER_REGISTRY}/${IMAGE_NAME}:latest" \
    -t "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
    -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}" \
    >>./build-log.txt
  docker push "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
    >>./build-log.txt
  echo "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" >>./output.txt

  if [[ $MIRROR == "true" && $PUBLIC_IMAGE_NAME ]]; then
    echo "Building public image : ${PUBLIC_IMAGE_NAME}:${IMG_TAG}"
    sed -e "s/registry.gitlab.com\/piximos\/scripted-atoms\//piximos\//g" -i "${DOCKER_IMAGE_PATH}"
    docker build --cache-from "${PUBLIC_IMAGE_NAME}:latest" \
      -t "${PUBLIC_IMAGE_NAME}:${IMG_TAG}" \
      -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}" \
      >>./build-log.txt
    docker push "${PUBLIC_IMAGE_NAME}:${IMG_TAG}" \
      >>./build-log.txt

    echo "${PUBLIC_IMAGE_NAME}:${IMG_TAG}" >>./output.txt
  fi
done
