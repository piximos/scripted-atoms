FROM registry.gitlab.com/piximos/scripted-atoms/scripted-task-atoms-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV ST_IS_SLEEPER_SCRIPT "false"
ENV ST_SLEEP_DURATION 60

ENV ST_SLACK_TOKEN ""
ENV ST_SLACK_CHANNEL ""
ENV ST_SLACK_ICON_URL ""
ENV ST_SLACK_USER_NAME ""

ENV ST_PING_HTTPS "true"
ENV ST_PING_HOST ""
ENV ST_PING_PATH ""
ENV ST_PING_AUTHENTICATION "none"
ENV ST_PING_AUTH_USER ""
ENV ST_PING_AUTH_PASSWORD ""
ENV ST_PING_AUTH_HEADER ""
ENV ST_PING_AUTH_HEADER_CONTENT ""
ENV ST_PING_EXPECTED_RESPONSE 200

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt

COPY config-validator.py /validators/config-validator.py
COPY scripted-atom /scripted-atom
