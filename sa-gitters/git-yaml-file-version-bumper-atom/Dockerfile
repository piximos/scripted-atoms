ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-gitter:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ATOM_ROBOT_USERNAME "dhraief.youssef@gmail.com"
ENV ATOM_ROBOT_EMAIL "scripted-atom"
ENV REPO_SCHEMA "https"
ENV REPO_BRANCH "master"
ENV VERSION_BUMP_MESSAGE_PREFIX "Bumped version to"
ENV BUMP_TYPE "minor"
ENV VERSION_DELIMITER "-"
ENV REPO_TARGET "/scripted-atom/repo"

RUN apk update \
 && wget $(curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4) -O /usr/bin/yq \
 && chmod +x /usr/bin/yq \
 && rm -rf /var/cache/apk/*

RUN mkdir ~/.ssh

COPY env-variables-template.json $ENV_TEMPLATE_PATH
COPY runner.sh $RUNNER_FILE_PATH
