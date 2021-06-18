ARG SA_BASE_VERSION="latest"
FROM scriptedatom/ssa-base:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ATOM_ROBOT_USERNAME "dhraief.youssef@gmail.com"
ENV ATOM_ROBOT_EMAIL "scripted-atom"
ENV ORIGIN_REPO_SCHEMA "https"
ENV REMOTE_REPO_SCHEMA "https"
ENV REPO_TARGET "/scripted-atom/repo"

RUN apk update \
 && apk add git \
 && rm -rf /var/cache/apk/*

RUN mkdir ~/.ssh

