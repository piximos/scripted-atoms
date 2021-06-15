#!/bin/bash

if [[ -z ${SA_BASE_VERSION} ]]; then
  echo "Missing 'SA_BASE_VERSION' variable"
  exit 1
fi

echo "Building 'latest' tag."
DOCKER_BUILDKIT=1 docker build \
  --build-arg SA_BASE_VERSION="${SA_BASE_VERSION}" \
  -t "${IMAGE_NAME}" \
  -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"

echo "Pushing 'latest' tag."
docker push "${IMAGE_NAME}"
echo "Pushed public image : ${IMAGE_NAME}"

if [[ ${IMAGE_VERSION} ]]; then
  echo "Tagging versioned image."
  docker tag \
    "${IMAGE_NAME}:latest" \
    "${IMAGE_NAME}:${IMAGE_VERSION}"

  echo "Pushing image : ${IMAGE_NAME}:${IMAGE_VERSION}"

  docker push "${IMAGE_NAME}:${IMAGE_VERSION}"
  echo "Pushed public image : ${IMAGE_NAME}"
fi
