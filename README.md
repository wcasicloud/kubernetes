Kuberneters cluster install(k8s 安装说明)
====
# 安装前准备
## 1. DNS主机名设置
## 2. 所有主机安装docker
```bash
ansible-playbook -i test_hosts -u root --limit 'all:!registry.doc.htyunlu.com' site.yml
```
如果通过rancher安装kuberneters需要低版本的docker
```bash
curl https://releases.rancher.com/install-docker/17.09.sh | sh
```
## 3. 安装docker registry
[Deploy a registry server](https://docs.docker.com/registry/deploying/)
## 4. 配置kubeadm
1. disable swap
```bash
source disable_swap.sh
```
2. install kubeadm via aliyun repo
```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=http://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=http://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
       http://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
yum install -y yum install -y kubelet kubeadm kubectl
```
3. 配置内核参数
