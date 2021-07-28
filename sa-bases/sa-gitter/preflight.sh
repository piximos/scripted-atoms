#!/bin/bash

git config --global user.name "$ATOM_ROBOT_USERNAME"
git config --global user.email "$ATOM_ROBOT_EMAIL"

bash -c "$@"