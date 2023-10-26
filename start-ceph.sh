#!/bin/bash
set -ex

cd ceph/build
ninja vstart
../src/vstart --debug --new -x --localhost --bluestore --bluestore-devs /dev/nvme0n1
cp ceph.conf /etc/ceph
cp keyring /etc/ceph
ceph -s
rados df
