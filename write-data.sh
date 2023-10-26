#!/bin/bash
set -ex

mkdir -p /mnt/cephfs/dataset

# download a 200MB file
wget http://ipv4.download.thinkbroadband.com/200MB.zip -O 200MB.zip

# copy the file 100 times into /mnt/cephfs/dataset
for i in {1..100}; do
    cp 200MB.zip /mnt/cephfs/dataset/200MB-$i.zip
done
