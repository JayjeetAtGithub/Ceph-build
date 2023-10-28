#!/bin/bash
set -ex

mkdir -p /mnt/cephfs/dataset

# download a test file
if [ ! -d "test.zip" ]; then
    wget http://link.testfile.org/150MB -O test.zip
fi

# copy the file 100 times into /mnt/cephfs/dataset
for i in {1..100}; do
    cp test.zip /mnt/cephfs/dataset/test-$i.zip
done
