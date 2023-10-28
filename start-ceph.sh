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

# init cephfs
./bin/ceph osd pool create cephfs_data 32 32 replicated
./bin/ceph osd pool create cephfs_metadata 32 32 replicated
./bin/ceph fs new cephfs cephfs_metadata cephfs_data
mkdir -p /mnt/cephfs

sleep 5
ceph-fuse /mnt/cephfs
