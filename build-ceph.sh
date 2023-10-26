#!/bin/bash
set -ex

if [ ! -d "ceph" ]; then
    git clone https://github.com/ceph/ceph.git
fi

cd ceph
git submodule update --init --recursive
git checkout v17.2.0

./install-deps.sh
sudo apt install -y cmake g++-13 libboost-all-dev

rm -rf build
 ./do_cmake.sh
cd build
ninja -j$(nproc)
