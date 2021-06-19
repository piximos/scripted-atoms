#!/bin/bash

generate_new_version() {
  # Transform version to array of numbers
  IFS=', ' read -r -a latest_version_elements <<<"$(echo "${1}" | grep -Eo '^([0-9]+(\-|\_|\.)[0-9]+)' | tr "-" ' ' | tr "_" ' ' | tr "." ' ')"
  # Extract minor and major version numbers
  minor_version=${latest_version_elements[${#latest_version_elements[@]} - 1]}
  major_version=${latest_version_elements[${#latest_version_elements[@]} - 2]}

  if [[ $BUMP_TYPE == "minor" ]]; then
    # Bump minor version
    target_version="$major_version$VERSION_DELIMITER$((minor_version + 1))"
  else
    # Bump major version
    target_version="$((major_version + 1))$VERSION_DELIMITER$minor_version"
  fi
  echo "$target_version"
}

switch_git_branch(){
  git rev-parse --verify "$REPO_BRANCH" >/dev/null 2>/dev/null
  if [ $? -eq 0 ]; then
    git checkout "$REPO_BRANCH"
  else
    git checkout -b "$REPO_BRANCH"
    fi
}

# Init global git configs
git config --global user.email "$ATOM_ROBOT_USERNAME"
git config --global user.name "$ATOM_ROBOT_EMAIL"

# Compose git URL with basic auth
repo_url="$REPO_SCHEMA://$REPO_USER:$REPO_TOKEN@$REPO_URI"

# Clone repo
git clone "$repo_url" "$REPO_TARGET" </dev/null
cd "$REPO_TARGET" || exit 1
switch_git_branch

# Retrieve latest version
latest_version="$(yq eval "$VERSION_PATH" "$VERSION_FILE" 2>/dev/null)"
if [[ -z $latest_version || "$latest_version" == "null" ]]; then
    latest_version="0-0"
fi
# Bump version
target_version=$(generate_new_version "$latest_version")
echo "Version bump : $latest_version -> $target_version"
yq e "$VERSION_PATH |= $target_version " "$VERSION_FILE" -i
git add "$VERSION_FILE"

if [[ "$ADD_GIT_LOG" == "true" ]]; then
  #Add git log
  echo -e "## $target_version \n\n Commit : \`$(git rev-parse HEAD)\`\n\n Author : $(git log -1 --format='%an') <$(git log -1 --format='Author : %ae')> \n\n Date \t: $(git log -1 --format='%cd') \n" > "$GIT_LOG_PATH"
  git add "$GIT_LOG_PATH"
fi

# Committing changes
git commit -m "$VERSION_BUMP_MESSAGE_PREFIX $target_version"
# Push version bump
git push origin "$REPO_BRANCH"
