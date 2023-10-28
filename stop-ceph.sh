#!/bin/bash
set -eu

blkdev=$1

cd ceph/build
../src/stop.sh

wipefs -af ${blkdev}
dd if=/dev/zero of=${blkdev} bs=1M count=1
