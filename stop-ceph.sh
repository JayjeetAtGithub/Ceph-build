#!/bin/bash
set -eu

blkdev=$1

# delete the cephfs
cd ceph/build

fusermount -uz /mnt/cephfs || true
rm -rf /mnt/cephfs
bin/ceph fs fail cephfs || true
bin/ceph fs rm cephfs --yes-i-really-mean-it || true
bin/ceph osd pool delete cephfs_data cephfs_data --yes-i-really-really-mean-it || true
bin/ceph osd pool delete cephfs_metadata cephfs_metadata --yes-i-really-really-mean-it || true

../src/stop.sh

wipefs -af ${blkdev}
dd if=/dev/zero of=${blkdev} bs=1M count=1

rm -rf /etc/ceph/ceph.conf
rm -rf /etc/ceph/keyring
