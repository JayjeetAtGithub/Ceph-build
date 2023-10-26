#!/bin/bash
set -ex

mkdir -p /mnt/cephfs/dataset

# download a test file
wget http://link.testfile.org/150MB -O test.zip

# copy the file 100 times into /mnt/cephfs/dataset
for i in {1..100}; do
    cp test.zip /mnt/cephfs/dataset/test-$i.zip
done
