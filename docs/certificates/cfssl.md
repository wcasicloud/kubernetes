使用cfssl创建证书
===
证书默认生成存放的路径`/etc/kubernetes/ssl`
# cfssl安装
# 生成cfssl配置文件
参考文件[ca-config.json](certs/ca-config.json)
# 创建根证书请求
参考文件[ca-csr.json](certs/ca-csr.json)
# 根证书生成
```bash
cfssl gencert -initca ca-csr.json | cfssljson -bare ca
```
参考结果如下：
* [ca-key.pem](certs/ca-key.pem)
* [ca.csr](certs/ca.csr)
* [ca.pem](certs/ca.pem)
# etcd和master使用的证书
请求内容参考:[kubernetes-csr.json](certs/kubernetes-csr.json)
生成方法如下：
```bash
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kubernetes-csr.json | cfssljson -bare kubernetes
```
# 创建Admin证书
请求内容参考：[admin-csr.json](certs/admin-csr.json)
生成方法:
```bash
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes admin-csr.json | cfssljson -bare admin
```
# 发布证书
将所有证书发布到服务器上
```bash
ansible all -i test_hosts -m synchronize -a "src= /etc/kubernetes/ssl dest=/etc/kubernetes recursive=yes"
```
