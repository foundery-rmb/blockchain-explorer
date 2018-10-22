# Copyright Tecnalia Research & Innovation (https://www.tecnalia.com)
# Copyright Tecnalia Blockchain LAB
#
# SPDX-License-Identifier: Apache-2.0

FROM node:8

# default values pf environment variables
# that are used inside container

ENV DEFAULT_WORKDIR /opt
ENV EXPLORER_APP_PATH $DEFAULT_WORKDIR/explorer

# database configuration
ENV DATABASE_HOST 127.0.0.1
ENV DATABASE_PORT 5432
ENV DATABASE_NAME fabricexplorer
ENV DATABASE_USERNAME hppoc
ENV DATABASE_PASSWD password

ENV STARTUP_SCRIPT /opt

# set default working dir inside container
WORKDIR $DEFAULT_WORKDIR

# install required dependencies by NPM packages:
# current dependencies are: python, make, g++

RUN apt-get update && \
    apt-get install -y make g++ libssl-dev python2.7 python-pip jq postgresql-contrib && \
    rm -r /usr/lib/python*/ensurepip && \
    pip install --upgrade pip setuptools

# copy external data to container
COPY . $EXPLORER_APP_PATH

# install NPM dependencies
RUN cd $EXPLORER_APP_PATH && npm install && npm build

RUN npm install -g npm

# build explorer app
RUN cd $EXPLORER_APP_PATH/client && npm install

RUN cd $EXPLORER_APP_PATH/client &&  npm run build

# expose default ports
EXPOSE 8080

# run blockchain explorer main app
#CMD node $EXPLORER_APP_PATH/main.js && tail -f /dev/null
