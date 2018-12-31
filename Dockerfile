# Ubuntu 16.04 (xenial) from 2017-07-23
# https://github.com/docker-library/official-images/commit/0ea9b38b835ffb656c497783321632ec7f87b60c
FROM ubuntu@sha256:84c334414e2bfdcae99509a6add166bbb4fa4041dc3fa6af08046a66fed3005f

MAINTAINER shinyup.lee <leesy7070@gamil.com>

USER root

RUN mkdir /home/project

# Install Required Packages
## java, etc..
RUN dpkg --add-architecture i386 && \
		apt-get -y update && \
		apt-get install -y build-essential libtool pkg-config libssl-dev git autoconf automake python-dev && \
		apt-get install --no-install-recommends -y openjdk-8-jdk openjdk-8-jdk-headless openjdk-8-jre-headless ca-certificates-java && \
		apt-get install -qy --no-install-recommends libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386 && \
		apt-get install -y openssh-client telnet wget unzip && \
		apt-get install -qq -y curl && \
		apt-get install -y vim usbutils software-properties-common && \
		apt-get install -y sudo net-tools && \
		rm -rf /var/lib/apt/lists/*

## android file transfer
RUN	add-apt-repository ppa:samoilov-lex/aftl-stable && \
		apt-get update && \
		apt-get install -y android-file-transfer

## android SDK
ENV ANDROID_SDK_FILE sdk-tools-linux-4333796.zip
ENV ANDROID_SDK_URL https://dl.google.com/android/repository/$ANDROID_SDK_FILE

ENV ANDROID_HOME /usr/local/android/sdk
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/tools/bin
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/emulator

RUN mkdir -p $ANDROID_HOME
WORKDIR $ANDROID_HOME

RUN wget $ANDROID_SDK_URL && \
    unzip $ANDROID_SDK_FILE && \
    rm $ANDROID_SDK_FILE

RUN echo "y" | sdkmanager "platform-tools" \
		"platforms;android-27"
RUN echo "y" | sdkmanager \
		"system-images;android-27;google_apis;x86"

# "platforms;android-22" \
# "platforms;android-23" \
# "platforms;android-24" \
# "platforms;android-25" \
# "platforms;android-26" \
# "platforms;android-27" \
# "platforms;android-28"

# "system-images;android-22;google_apis;x86_64" \
# "system-images;android-23;google_apis;x86_64" \
# "system-images;android-24;google_apis;x86_64" \
# "system-images;android-25;google_apis;x86_64" \
# "system-images;android-26;google_apis;x86_64" \
# "system-images;android-27;google_apis;x86" \
# "system-images;android-28;google_apis;x86_64"

## watchman
ENV WATCHMAN_HOME /usr/local/watchman
RUN mkdir -p $WATCHMAN_HOME
WORKDIR $WATCHMAN_HOME

RUN git clone https://github.com/facebook/watchman.git $WATCHMAN_HOME && \
    cd $WATCHMAN_HOME && \
    git checkout v4.9.0 && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install

## nodejs, react-native
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && \
		apt-get install -y nodejs

# RUN npm install -g react@16.0 react-native-cli@2.0.1 react-native-maps@0.22.1 --save
RUN npm install -g react-native-cli@2.0.1 --save

WORKDIR /home/project
