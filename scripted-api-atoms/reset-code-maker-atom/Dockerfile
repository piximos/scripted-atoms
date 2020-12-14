FROM registry.gitlab.com/piximos/scripted-atoms/scripted-api-atoms-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV SA_REDIS_HOST ""
ENV SA_REDIS_PORT 6379
ENV SA_REDIS_PASSWORD ""
ENV SA_REDIS_DB 0
ENV SA_REDIS_KEY_PREFIX "atom"

ENV SA_RESET_CODE_TTL 900
ENV SA_RESET_CODE_FORMAT "alphanumeric-cased"
ENV SA_RESET_CODE_LENGTH 6
ENV SA_RESET_CODE_SPLIT true
ENV SA_RESET_CODE_SPLITTER "-"
ENV SA_RESET_CODE_SPLIT_EVERY 3

COPY config-validator.py /validators/config-validator.py

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt

COPY scripted-atom /scripted-atom

