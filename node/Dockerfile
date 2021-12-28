FROM balenalib/rpi-raspbian:stretch

RUN apt-get update --fix-missing
RUN apt-get install curl software-properties-common
RUN apt-get install python2.7 make
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo bash -

RUN apt-get install nodejs
RUN apt-get install build-essential
RUN mkdir -p /var/node/node_modules
VOLUME /var/node/node_modules

ADD polling.sh /polling.sh
RUN chmod 777 /polling.sh

ADD node.sh /node.sh
RUN chmod 777 /node.sh

ENTRYPOINT /node.sh
