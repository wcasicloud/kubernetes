#!/bin/bash
#
#
# disable kubelet service
ETCD_ENDPOINTS=https://172.17.60.113:2379
systemctl stop kubelet
kubeadm reset
# remove all etcd stored object
ETCDCTL_API=3 etcdctl \
--endpoints=$ETCD_ENDPOINTS  \
del /registry --prefix

rm -rf /etc/kubernetes/*.conf
rm -rf /etc/kubernetes/manifests/*.yaml
docker ps -a |awk '{print $1}' |xargs docker rm -f
