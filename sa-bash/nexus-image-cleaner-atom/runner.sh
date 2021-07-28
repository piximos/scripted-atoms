#!/bin/bash

nexus_api="$SA_NEXUS_SCHEMA://$SA_NEXUS_URI/service/rest/v1"

curl -s -u "$SA_NEXUS_USER:$SA_NEXUS_PASSWORD" \
  -X GET "$nexus_api/search?repository=$SA_NEXUS_REPOSITORY&name=$SA_DOCKER_IMAGE_NAME&version=$SA_DOCKER_IMAGE_TAG" |
  jq -c '.items[]' | while read -r docker_image; do
    image_id="$(jq -n "$docker_image" | jq -r '.id')"
    image_version="$(jq -n "$docker_image" | jq -r '.version')"
    image_name="$(jq -n "$docker_image" | jq -r '.name')"
    if [[ "$image_version" != "$TAG_TO_KEEP" ]]; then
      echo "Deleting the following 'image:tag' : $image_name:$image_version [id=$image_id]"
      echo "$docker_image" | jq -c '.assets[]' | while read -r docker_assets; do
        asset_id="$(jq -n "$docker_assets" | jq -r '.id')"
        echo "Deleting asset [id=$asset_id] for '$image_name:$image_version'"
        curl -s -u "$SA_NEXUS_USER:$SA_NEXUS_PASSWORD" \
          -X DELETE "$nexus_api/assets/$asset_id"
      done
      curl -s -u "$SA_NEXUS_USER:$SA_NEXUS_PASSWORD" \
        -X DELETE "$nexus_api/components/$image_id"
    fi
  done