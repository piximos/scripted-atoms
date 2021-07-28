#!/bin/bash

generate_new_tag() {
  # Transform tag to array of numbers
  IFS=', ' read -r -a latest_tag_elements <<<"$(echo "${1}" | grep -Eo '^([0-9]+(\-|\_|\.)[0-9]+)' | tr "-" ' ' | tr "_" ' ' | tr "." ' ')"
  # Extract minor and major version numbers
  minor_tag=${latest_tag_elements[${#latest_tag_elements[@]} - 1]}
  major_tag=${latest_tag_elements[${#latest_tag_elements[@]} - 2]}

  if [[ $BUMP_TYPE == "minor" ]]; then
    # Bump minor version
    target_tag="$major_tag$TAG_DELIMITER$((minor_tag + 1))"
  else
    # Bump major version
    target_tag="$((major_tag + 1))$TAG_DELIMITER$minor_tag"
  fi
  echo "$target_tag"
}

# Compose git URL with basic auth
repo_url="$REPO_SCHEMA://$REPO_USER:$REPO_TOKEN@$REPO_URI"

# Clone repo
git clone "$repo_url" "$REPO_TARGET" </dev/null
cd "$REPO_TARGET" || exit 1

# Retrieve latest tag
latest_tag=$(git describe --tags "$(git rev-list --tags --max-count=1)" 2>/dev/null || echo "0-0")
# Bump tag
target_tag=$(generate_new_tag "$latest_tag")
echo "Tag bump : $latest_tag -> $target_tag"
# Commit tag bump
git tag -a "$target_tag" -m "$TAG_BUMP_MESSAGE_PREFIX $target_tag"
# Push tag bump
git push origin --tags
