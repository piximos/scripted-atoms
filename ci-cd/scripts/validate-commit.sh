#!/bin/bash

branch_name=$CI_COMMIT_REF_NAME
echo "The current branch is : ${branch_name}"

if [[ $CI_COMMIT_REF_NAME =~ dev.*|develop.*|master$ ]] ; then
    echo "BRANCH NAME :  '$CI_COMMIT_REF_NAME' is valid."
    exit 0
else
    echo "BRANCH NAME '$CI_COMMIT_REF_NAME' is not a valid one. Please use a valid branch name."
    echo "A valid branch name must be 'master', starts with 'dev.*' or 'develop-'"
    exit 1
fi
