#!/bin/bash
set -eu

blkdev=$1

# delete the cephfs
fusermount -uz /mnt/cephfs
rm -rf /mnt/cephfs
ceph fs fail cephfs
ceph fs rm cephfs --yes-i-really-mean-it
ceph osd pool delete cephfs_data cephfs_data --yes-i-really-really-mean-it
ceph osd pool delete cephfs_metadata cephfs_metadata --yes-i-really-really-mean-it

cd ceph/build
../src/stop.sh

wipefs -af ${blkdev}
dd if=/dev/zero of=${blkdev} bs=1M count=1

rm -rf /etc/ceph/ceph.conf
rm -rf /etc/ceph/keyring
