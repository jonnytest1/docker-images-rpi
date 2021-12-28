FROM balenalib/raspberrypi3-ubuntu-openjdk:11

ARG MAVEN_VERSION=3.8.4
ARG USER_HOME_DIR="/root"

RUN sudo apt-get update && apt-get install zip unzip wget

COPY maven-${MAVEN_VERSION}.tar.gz ./maven-${MAVEN_VERSION}.tar.gz
RUN unzip maven-${MAVEN_VERSION}.tar.gz \
  && cd ./apache-maven-${MAVEN_VERSION} \
  && cp -r ./ /usr/bin/apache
  
ENV MAVEN_HOME="/usr/bin/apache"
ENV PATH="/usr/bin/apache/bin:$PATH"
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"


CMD ["mvn"]