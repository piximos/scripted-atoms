#!/bin/bash

if [[ -z ${SA_BETA_BUILD} ]]; then
  SA_BETA_BUILD="false"
fi

if [[ -z ${SA_BASE_IMAGE} ]]; then
  echo "Missing 'SA_BASE_IMAGE' variable"
  exit 1
fi

if [[ -z ${SA_TARGET} ]]; then
  echo "Missing 'SA_TARGET' variable"
  exit 1
fi

build_image() {
  base_img_tag="${1}"
  img_tag="${2}"
  target_img="${3}"
  echo "Building '${img_tag}' tag."
  DOCKER_BUILDKIT=1 docker build \
    --build-arg SA_BASE_IMAGE="${base_img_tag}" \
    --target "${target_img}" \
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

PUBLIC_VERSION="$(git describe | grep -Eo '^([0-9]+\-[0-9]+\-[0-9]+)' | tr '-' '.')"
REPO_VERSION="sa-$PUBLIC_VERSION"

if [[ "$SA_BETA_BUILD" == "true" ]]; then
  REPO_VERSION="$CI_COMMIT_REF_NAME-${CI_COMMIT_SHA:0:8}"
fi

build_image "${SA_BASE_IMAGE}" "${REPO_VERSION}" "${SA_TARGET}"
push_image "${REPO_VERSION}"

if [[ "$SA_BETA_BUILD" != "true" ]]; then
  build_image "${SA_BASE_IMAGE}" "${PUBLIC_VERSION}" "${SA_TARGET}"
  push_image "${PUBLIC_VERSION}"

  re_tag_image "${REPO_VERSION}" "latest"
  push_image "latest"
fi

export SUCCESS="true"
[ $? -eq 0 ] || export SUCCESS="false"
./ci-cd/scripts/pipeline-after-build.sh