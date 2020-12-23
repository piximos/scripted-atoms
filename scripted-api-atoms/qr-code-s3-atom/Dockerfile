FROM registry.gitlab.com/piximos/scripted-atoms/scripted-api-atoms-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV QR_TMP_FOLDER "/tmp/scripted-atom"

ENV SA_QR_FILL_COLOR "#121128"
ENV SA_QR_BACKGROUND_COLOR "#dcdbdb"

ENV SA_BUCKET_ENDPOINT ""
ENV SA_BUCKET_ACCESS_KEY ""
ENV SA_BUCKET_SECRET_KEY ""
ENV SA_BUCKET_NAME ""
ENV SA_BUCKET_PATH ""
ENV SA_BUCKET_SIGN_OBJECT "true"

RUN mkdir "$QR_TMP_FOLDER"

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt

COPY config-validator.py /validators/config-validator.py
COPY scripted-atom /scripted-atom

