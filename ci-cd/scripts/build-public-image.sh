#!/bin/bash

if [[ -z ${SA_BETA_BUILD} ]]; then
  SA_BETA_BUILD="false"
fi

if [[ -z ${SA_BASE_VERSION} ]]; then
  echo "Missing 'SA_BASE_VERSION' variable"
  exit 1
fi

if [[ -z ${IMAGE_VERSION} ]]; then
  echo "Missing 'IMAGE_VERSION' variable"
  exit 1
fi

build_image() {
  base_img_tag="${1}"
  img_tag="${2}"
  echo "Building '${img_tag}' tag."
  DOCKER_BUILDKIT=1 docker build \
    --build-arg SA_BASE_VERSION="${base_img_tag}" \
    -t "${IMAGE_NAME}:${img_tag}" \
    -f "${DOCKER_IMAGE_PATH}" "${DOCKER_BUILD_CONTEXT}"
}

re_tag_image() {
  src_tag="${1}"
  dst_tag="${2}"
  echo "Tagging '${dst_tag}' from '${src_tag}'."
  docker tag \
    "${IMAGE_NAME}:${src_tag}" \
    "${IMAGE_NAME}:${dst_tag}"
}

push_image() {
  img_tag="${1}"
  echo "Pushing '${img_tag}' tag."
  docker push "${IMAGE_NAME}:${img_tag}"
  echo "Pushed public image : ${IMAGE_NAME}"
}

REPO_VERSION="sa-$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')"

build_image "${SA_BASE_VERSION}" "${REPO_VERSION}"
push_image "${REPO_VERSION}"

if [[ "$SA_BETA_BUILD" != "true" ]]; then
  build_image "${SA_BASE_VERSION}" "${IMAGE_VERSION}"
  push_image "${IMAGE_VERSION}"

  re_tag_image "${IMAGE_VERSION}" "latest"
  push_image "latest"
fi
