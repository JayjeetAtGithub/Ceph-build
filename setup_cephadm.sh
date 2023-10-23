#!/bin/bash
set -eu

HOSTS=${1:-node0}

IFS=',' read -ra HOST_LIST <<< "$HOSTS"; unset IFS
HOST_LIST=${HOST_LIST[@]}

exec_cmd() {
    echo "$1: $2"

    hostname=$(hostname -s)
    if [ "$hostname" == "$1" ]; then
        bash $2
        return
    fi

    ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i $1 $2
}

# install cephadm on hosts
for node in ${HOST_LIST}; do
    exec_cmd $node "curl --silent --remote-name --location https://github.com/ceph/ceph/raw/quincy/src/cephadm/cephadm"
    exec_cmd $node "chmod +x cephadm"
    exec_cmd $node "./cephadm add-repo --release quincy"
    exec_cmd $node "./cephadm install"
    exec_cmd $node "which cephadm"
done
