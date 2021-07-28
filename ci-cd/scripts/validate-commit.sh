#!/bin/bash

branch_name=$CI_COMMIT_REF_NAME
echo "The current branch is : ${branch_name}"

if [[ $CI_COMMIT_REF_NAME =~ ^(ci|sa|ssa|saa|sta)\-?(\-.*)?$|^master$ ]] ; then
    echo "BRANCH NAME :  '$CI_COMMIT_REF_NAME' is valid."
    exit 0
else
    echo "BRANCH NAME '$CI_COMMIT_REF_NAME' is not a valid one. Please use a valid branch name."
    echo "A valid branch name must be 'master', starts with one of the following values"
    echo -e "\t - 'ci-*"
    echo -e "\t - 'sa-*"
    echo -e "\t - 'ssa-*"
    echo -e "\t - 'saa-*"
    echo -e "\t - 'sta-*"
    exit 1
fi
