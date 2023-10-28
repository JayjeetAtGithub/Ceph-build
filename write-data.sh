#!/bin/bash
set -ex

mkdir -p /mnt/cephfs/dataset

# download a test file
if [ ! -f "test.zip" ]; then
    wget http://link.testfile.org/150MB -O test.zip
fi

# copy the file 100 times into /mnt/cephfs/dataset
for i in {1..1000}; do
    UUID=$(cat /proc/sys/kernel/random/uuid)
    cp test.zip /mnt/cephfs/dataset/test-$UUID.zip
done
