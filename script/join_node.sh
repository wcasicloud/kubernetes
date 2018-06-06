#!/bin/bash
#
# kubeadm join node
api_server=10.153.51.221:6443
token=b99a00.a144ef80536d4344
token_cert=sha256:87df77cbcbb7b05d42418f92332965312a41fac76e2970701cf2a153fabe0dca

kubeadm join ${api_server} --token ${token} --discovery-token-ca-cert-hash  ${token_cert}

