#!/bin/bash
set -eu

mkfs.ext4 -L data /dev/nvme0n1
mkdir -p /mnt/data
mount -o defaults /dev/nvme0n1 /mnt/data
cd /mnt/data
