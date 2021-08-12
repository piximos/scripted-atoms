ARG SA_BASE_VERSION="latest"
FROM scriptedatom/sa-fastapi:${SA_BASE_VERSION}

MAINTAINER Youssef Dhraief (piximos) <dhraief.youssef@gmail.com>

ENV QR_TMP_FOLDER "/tmp/scripted-atom"

ENV SA_QR_FILL_COLOR "#121128"
ENV SA_QR_BACKGROUND_COLOR "#dcdbdb"

RUN mkdir "$QR_TMP_FOLDER"

RUN apk add --no-cache tiff-dev jpeg-dev openjpeg-dev zlib-dev freetype-dev lcms2-dev \
    libwebp-dev tcl-dev tk-dev harfbuzz-dev fribidi-dev libimagequant-dev \
    libxcb-dev libpng-dev build-base \
 && rm -rf /var/cache/apk/*

COPY additional-requirements.txt additional-requirements.txt
RUN pip install --no-cache-dir -r additional-requirements.txt
COPY scripted-atom /scripted-atom

