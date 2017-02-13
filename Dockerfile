FROM zanyxdev/dev-java-base:latest

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

RUN curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/snowdream/51-android/master/51-android.rules && \
    chmod a+r /etc/udev/rules.d/51-android.rules

#Installs configure and update Android SDK with components
ENV ANDROID_HOME /opt/android-sdk-linux 
ENV PATH ${PATH}:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools
ENV ANDROID_COMPONENTS  platform-tools,android-25, android-21, build-tools-25.0.2, build-tools-21.1.2
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-google-m2repository,extra-google-google_play_services \
	      extra-google-admob_ads_sdk, extra-google-analytics_sdk_v2, extra-google-google_play_services, \
	      extra-google-market_apk_expansion, extra-google-market_licensing, \
	      extra-google-play_billing, extra-google-webdriver

#ENV ANDROID_SOURCE source-25, source-21

#sys-img-x86_64-google_apis-25
ENV GOOGLE_IMG sys-img-x86_64-google_apis-21
ENV GOOGLE_APIS addon-google_apis-google-21

RUN curl -L https://dl.google.com/android/repository/tools_r25.2.5-linux.zip -o /tmp/tools_r25.2.5-linux.zip && \
    unzip /tmp/tools_r25.2.5-linux.zip -d /opt/android-sdk-linux && \
    rm -f /tmp/tools_r25.2.5-linux.zip

RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_COMPONENTS}" && \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_COMPONENTS}"  && \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_IMG}"  && \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_APIS}" 

#ENV JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"

#set Russian locale
#ENV LC_ALL ru_RU.UTF-8 
#ENV LANG ru_RU.UTF-8 
#ENV LANGUAGE ru_RU.UTF-8 

CMD /bin/bash