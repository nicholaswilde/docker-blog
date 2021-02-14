FROM ubuntu:20.04 as dl
ARG VERSION
ARG CHECKSUM=e9524d5980a98250804a4dc91fbab90bbef258a9625b8f38e1535944e4e75de9
ARG FILENAME="${VERSION}.tar.gz"
WORKDIR /tmp
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    wget=1.20.3-1ubuntu1 \
    ca-certificates=20210119~20.04.1 && \
  echo "**** download app ****" && \
  mkdir /app && \
  wget --no-check-certificate "https://github.com/m1k1o/blog/archive/${FILENAME}" && \
  echo "${CHECKSUM}  ${FILENAME}" | sha256sum -c && \
  tar -xvf "${FILENAME}" --strip-components 1 -C /app
WORKDIR /app
RUN \
  echo "**** cleanup ****" && \
  rm -rf \
    Dockerfile \
    docker-compose.* \
    ./*.md \
    .gitignore

FROM php:7.4-apache
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="nicholaswilde"
RUN \
  echo "**** install packages ****" && \
  set -eux && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    libcurl4-openssl-dev=7.64.0-4+deb10u1 \
    zlib1g-dev=1:1.2.11.dfsg-1 \
    libpng-dev=1.6.36-6 \
    libjpeg-dev=1:1.5.2-2+deb10u1 \
    libwebp-dev=0.6.1-2 \
    libxpm-dev=1:3.5.12-1 \
    libfreetype6-dev=2.9.1-3+deb10u2 && \
  rm -rf /var/lib/apt/lists/* && \
  echo "**** configure extensions ****" && \
  docker-php-ext-configure gd \
    --enable-gd \
    --with-jpeg \
    --with-webp \
    --with-xpm \
    --with-freetype && \
  echo "**** install extensions ****" && \
  docker-php-ext-install \
    curl \
    gd \
    pdo \
    pdo_mysql && \
  a2enmod rewrite && \
  echo "**** cleanup ****" && \
  apt-get clean && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/ \
    /var/tmp/*
COPY --from=dl --chown=33:33 /app /var/www/html
VOLUME /var/www/html/data
