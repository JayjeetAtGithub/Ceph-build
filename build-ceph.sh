#!/bin/bash
set -ex

# debug build

if [ ! -d "ceph" ]; then
    git clone https://github.com/JayjeetAtGithub/ceph.git
fi

cd ceph
git submodule update --init --recursive
git checkout v17.2.0-oas

sudo apt-get update
./install-deps.sh
./run-make-check.sh

sudo apt install -y cmake libboost-all-dev ceph-common ceph-fuse

rm -rf build
./do_cmake.sh -DWITH_SYSTEM_BOOST=ON -DWITH_RDMA=OFF -DWITH_RBD=OFF -DWITH_KRBD=OFF -DWITH_RADOSGW=OFF -DWITH_MANPAGE=OFF -DWITH_BABELTRACE=OFF -DWITH_MGR_DASHBOARD_FRONTEND=OFF
cd build
ninja -j$(nproc)
