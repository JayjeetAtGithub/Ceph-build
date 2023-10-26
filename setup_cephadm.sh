#!/bin/bash
set -eu

HOSTS=${1:-node0}
CEPH_PUBKEY_PATH="/etc/ceph/ceph.pub"

IFS=',' read -ra HOST_LIST <<< "$HOSTS"; unset IFS
HOST_LIST=${HOST_LIST[@]}

exec_cmd() {
    echo "$1: $2"

    hostname=$(hostname -s)
    if [ "$hostname" == "$1" ]; then
        $2
        return
    fi

    ssh -o StrictHostKeyChecking=no $1 $2
}

# install cephadm on hosts
for node in ${HOST_LIST}; do
    exec_cmd ${node} "curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm"
    exec_cmd ${node} "chmod +x cephadm"
    exec_cmd ${node} "./cephadm add-repo --release quincy"
    exec_cmd ${node} "./cephadm install"
    exec_cmd ${node} "which cephadm"
done


# initiate a mon
./cephadm bootstrap --mon-ip 10.10.1.1
./cephadm install ceph-common

# prevent ceph from automatically starting a mon upon adding a new host
ceph orch apply mon --unmanaged

# copy the ceph public key to all hosts
for node in ${HOST_LIST}; do
    ssh-copy-id -f -i ${CEPH_PUBKEY_PATH} root@${node}
done

