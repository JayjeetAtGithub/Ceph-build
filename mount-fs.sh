#!/bin/bash
set -eu

blkdev=$1

mkfs.ext4 -L data ${blkdev}
mkdir -p /mnt/data
mount -o defaults ${blkdev} /mnt/data
cd /mnt/data
