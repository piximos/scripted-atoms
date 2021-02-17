#!/bin/bash

set -x # echo on

sed -e "s/registry.gitlab.com\/piximos\/scripted-atoms\//piximos\//g" -i "${DOCKER_IMAGE_PATH}"
docker build --cache-from "${IMAGE_NAME}:${IMG_TAG}" -t "${IMAGE_NAME}:${IMG_TAG}" -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
docker push "${IMAGE_NAME}:${IMG_TAG}"

echo "${IMAGE_NAME}:${IMG_TAG}" >> ./build-artifacts/output.txt