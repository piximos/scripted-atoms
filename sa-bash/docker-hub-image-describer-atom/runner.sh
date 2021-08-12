#!/bin/bash

DOCKER_HUB_API="https://hub.docker.com/v2"
TOKEN=$(curl -s -H "Content-Type: application/json" -X POST -d '{"username": "'${DOCKER_USERNAME}'", "password": "'${DOCKER_PASSWORD}'"}' "${DOCKER_HUB_API}/users/login/" | jq -r .token)

push_readme() {

  result=$(jq -n --arg msg "$(<"$README_FILE_PATH")" \
    '{"registry":"registry-1.docker.io","full_description": $msg }' |
    curl -s \
      -w ' { "statusCode": %{http_code}} ' \
      "${DOCKER_HUB_API}/repositories/${DOCKER_IMAGE_NAME}/" \
      -d @- -X PATCH \
      -H "Content-Type: application/json" \
      -H "Authorization: JWT ${TOKEN}" | jq -ren '[inputs] | add')

  output=$(echo "$result" | jq -rc 'del(.statusCode)')
  status_code=$(echo "$result" | jq -r .statusCode)

  if [[ ${status_code} == 20* ]]; then
    echo "[INFO] Successfully updated Docker Hub description for [IMAGE='${DOCKER_IMAGE_NAME}']"
  else
    echo "[ERROR, CODE='${status_code}'] Failed to update image description in Docker Hub" > /dev/stderr
    echo "[ERROR_OUTPUT] ${output}" > /dev/stderr
    exit 1
  fi

}

if [[ -f ${README_FILE_PATH} ]]; then
  push_readme
else
  echo "[ERROR] Failed to locate README file under [PATH='${README_FILE_PATH}']"
  if [[ "${EXIT_GRACEFULLY}" != "true" ]]; then
    exit 1
  fi
fi

exit 0
