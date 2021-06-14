#!/bin/bash

if [[ -z ${BUILD_FOR_PRIVATE_REGISTRY} ]]; then
  BUILD_FOR_PRIVATE_REGISTRY="true"
fi
if [[ $CI_COMMIT_REF_NAME != "major-release" && $CI_COMMIT_REF_NAME != "minor-release" && $CI_COMMIT_REF_NAME != "master" ]]; then
  IMG_TAGS=("$CI_COMMIT_REF_NAME$IMG_COMPLEMENTARY_TAG")
elif [[ $CI_COMMIT_REF_NAME = "master" ]]; then
  IMG_TAGS=("latest$IMG_COMPLEMENTARY_TAG" "$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')$IMG_COMPLEMENTARY_TAG")
else
  IMG_TAGS=("$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')$IMG_COMPLEMENTARY_TAG")
fi

for IMG_TAG in "${IMG_TAGS[@]}"; do
  if [[ $BUILD_FOR_PRIVATE_REGISTRY = "true" ]]; then
  echo "Building image for private registry : ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
    sed -e "s:scriptedatom/:$CI_REGISTRY/piximos/scripted-atoms/:g" -i "${DOCKER_IMAGE_PATH}"
  DOCKER_BUILDKIT=1 docker build \
    -t "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}" \
    -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
  echo "Pushing image to private registry : ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
  docker push "${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
  echo "Pushed image to private registry : ${DOCKER_REGISTRY}/${IMAGE_NAME}:${IMG_TAG}"
  fi

  if [[ $MIRROR == "true" && $PUBLIC_IMAGE_NAME ]]; then
    echo "Building public image : ${PUBLIC_IMAGE_NAME}:${IMG_TAG}"
    DOCKER_BUILDKIT=1 docker build \
      -t "${PUBLIC_IMAGE_NAME}:${IMG_TAG}" \
      -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
    echo "Pushing public image : ${PUBLIC_IMAGE_NAME}:${IMG_TAG}"
    docker push "${PUBLIC_IMAGE_NAME}:${IMG_TAG}"
    echo "Pushed public image : ${PUBLIC_IMAGE_NAME}:${IMG_TAG}"
  fi
done
