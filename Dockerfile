FROM ubuntu:16.04

MAINTAINER ZanyXDev "zanyxdev@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/zanyxdev/dev-android-sdk.git" \
      org.label-schema.vcs-ref=$VCS_REF \
org.label-schema.schema-version="1.0.0-rc1"

# Dependencies
RUN apt-get update && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* 

#ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

#set Russian locale
#ENV LC_ALL ru_RU.UTF-8 
#ENV LANG ru_RU.UTF-8 
#ENV LANGUAGE ru_RU.UTF-8 

CMD /bin/bash