#!/bin/bash

# Init global git configs
git config --global user.email "$ATOM_ROBOT_USERNAME"
git config --global user.name "$ATOM_ROBOT_EMAIL"

# Compose git URL with basic auth
origin_repo_url="$ORIGIN_REPO_SCHEMA://$ORIGIN_REPO_USER:$ORIGIN_REPO_TOKEN@$ORIGIN_REPO_URI"
remote_repo_url="$REMOTE_REPO_SCHEMA://$REMOTE_REPO_USER:$REMOTE_REPO_TOKEN@$REMOTE_REPO_URI"

# Clone repo
git clone "$origin_repo_url" "$REPO_TARGET" </dev/null
cd "$REPO_TARGET" || exit 1
git remote add atom "$remote_repo_url"
echo "Mirroring data to remote target"
git push atom --all
git push atom --tags
