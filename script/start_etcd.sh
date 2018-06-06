#!/bin/bash
export ETCD_DATA_DIR="/var/lib/etcd/master1.etcd"
export ETCD_LISTEN_PEER_URLS="https://172.17.60.113:2380"
export ETCD_LISTEN_CLIENT_URLS="https://172.17.60.113:2379,http://127.0.0.1:2379"
export ETCD_NAME="master1"
export ETCD_INITIAL_ADVERTISE_PEER_URLS="https://172.17.60.113:2380"
export ETCD_ADVERTISE_CLIENT_URLS="https://172.17.60.113:2379"
export ETCD_INITIAL_CLUSTER="master1=https://172.17.60.113:2380,master1=https://172.17.60.114:2380,master1=https://172.17.60.115:2380,"
export ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
export ETCD_INITIAL_CLUSTER_STATE="new"
export ETCD_CERT_FILE="/etc/kubernetes/ssl/kubernetes.pem"
export ETCD_KEY_FILE="/etc/kubernetes/ssl/kubernetes-key.pem"
export ETCD_TRUSTED_CA_FILE="/etc/kubernetes/ssl/ca.pem"
export ETCD_PEER_CERT_FILE="/etc/kubernetes/ssl/kubernetes.pem"
export ETCD_PEER_KEY_FILE="/etc/kubernetes/ssl/kubernetes-key.pem"
export ETCD_PEER_TRUSTED_CA_FILE="/etc/kubernetes/ssl/ca.pem"

/usr/bin/etcd --debug

#master1=http://127.0.0.1:2380,master1=https://172.17.60.114:2380,master1=https://172.17.60.115:2380
#master1=https://172.17.60.113:2380,master1=https://172.17.60.114:2380,master1=https://172.17.60.115:2380,master1=http://127.0.0.1:2380,master1=http://172.17.60.113:2380
