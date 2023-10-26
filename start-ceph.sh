#!/bin/bash
set -ex

cd ceph/build
ninja vstart
MON=1 OSD=1 MDS=1 MGR=1 ../src/vstart --debug --new -x --localhost --bluestore --bluestore-devs /dev/nvme0n1
cp ceph.conf /etc/ceph
cp keyring /etc/ceph
ceph -s
rados df
