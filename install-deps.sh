#!/bin/bash
set -ex

sudo apt-get update
sudo apt-get install -y python3-dev \
                        python3-pip \
                        python3-venv \
                        python3-sphinx \
                        python3-routes
 
pip3 install Cython

sudo apt-get install -y curl \
                        cmake \
                        ninja-build \
                        libibverbs-dev \
                        libudev-dev \
                        libblkid-dev \
                        libkeyutils-dev \
                        libldap-dev \
                        libfuse-dev \
                        libcryptsetup-dev \
                        libaio-dev \
                        libsqlite3-dev \
                        libsnappy-dev \
                        liblz4-dev \
                        libgoogle-perftools-dev \
                        libcurl4-openssl-dev \
                        liboath-dev \
                        liblttng-ust-dev \
                        libbabeltrace-dev \
                        libthrift-dev \
                        liblua5.3-dev \
                        libnl-genl-3-dev \
                        libcap-ng-dev \
                        libicu-dev \
                        librabbitmq-dev \
                        librdkafka-dev

