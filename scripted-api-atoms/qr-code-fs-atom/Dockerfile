FROM registry.gitlab.com/piximos/scripted-atoms/scripted-api-atoms-base:latest

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV QR_TMP_FOLDER "/tmp/scripted-atom"

ENV SA_QR_FILL_COLOR "#121128"
ENV SA_QR_BACKGROUND_COLOR "#dcdbdb"

RUN mkdir "$QR_TMP_FOLDER"

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt
COPY scripted-atom /scripted-atom

