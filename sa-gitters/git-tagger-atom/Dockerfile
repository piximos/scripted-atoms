ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-gitter:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ATOM_ROBOT_USERNAME "dhraief.youssef@gmail.com"
ENV ATOM_ROBOT_EMAIL "scripted-atom"
ENV REPO_SCHEMA "https"
ENV TAG_BUMP_MESSAGE_PREFIX "Bumped tag to"
ENV BUMP_TYPE "minor"
ENV TAG_DELIMITER "-"
ENV REPO_TARGET "/scripted-atom/repo"

RUN mkdir ~/.ssh

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH
