FROM scriptedatom/saa-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV SA_REDIS_HOST ""
ENV SA_REDIS_PORT 6379
ENV SA_REDIS_PASSWORD ""
ENV SA_REDIS_DB 0
ENV SA_REDIS_KEY_PREFIX "atom"

ENV SA_OPT_TTL 900
ENV SA_OPT_FORMAT "alphanumeric-cased"
ENV SA_OPT_LENGTH 6
ENV SA_OPT_SPLIT true
ENV SA_OPT_SPLITTER "-"
ENV SA_OPT_SPLIT_EVERY 3

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt

COPY config-validator.py /validators/config-validator.py
COPY scripted-atom /scripted-atom

