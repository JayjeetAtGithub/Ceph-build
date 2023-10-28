#!/bin/bash
set -ex

blkdev=$1

cd ceph/build
ninja vstart
MON=1 OSD=1 MDS=1 MGR=1 ../src/vstart.sh --debug --new -x --localhost --bluestore --bluestore-devs ${blkdev}
cp ceph.conf /etc/ceph/ceph.conf
cp keyring /etc/ceph/keyring
./bin/ceph -s
./bin/rados df
