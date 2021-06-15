ARG SA_BASE_VERSION="latest"
FROM scriptedatom/saa-base:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV TMP_DIR "/tmp/scripted-atom"

ENV SA_BUCKET_ENDPOINT ""
ENV SA_BUCKET_ACCESS_KEY ""
ENV SA_BUCKET_SECRET_KEY ""
ENV SA_BUCKET_NAME ""

RUN mkdir "$TMP_DIR"

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt

COPY config-validator.py /validators/config-validator.py
COPY scripted-atom /scripted-atom

