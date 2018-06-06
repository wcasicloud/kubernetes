Certificate authentication
===
基于Openssl创建CA并颁发证书说明
--
# 一、基本流程
> 1. 创建CA根Key
> 2. 创建CA根证书
> 3. 为服务器生成SSL密钥
> 4. 为服务器生成证书签署请求
> 5. 通过CA颁发证书
# 二、实施步骤举例
在测试环境中需要给如下服务器颁发Server证书
> master1.doc.htyunlu.com 用做k8s的Master服务器，安装apiserver, controller等服务
>registry.doc.htyunlu.com 负责docker的registry

CA在master1上。工作目录`/data/ca`存储相关证书文件。
## 1. 创建CA根Key
```bash
openssl genrsa -out cakey.pem 2048
```
其中`genrsa`是用来生成rsa的选项，`2048`是生成的位数。

可以通过`rsa`查看公钥密钥。
```bash
#查看公钥
openssl rsa -in cakey.pem -pubout
#查看私钥
openssl rsa -in cakey.pem
```
## 2. 创建CA根证书
有了密钥以后就开始创建CA自签名的证书。在证书需要填写一些组织信息，openssl中称为`subject`。在测试环境里subject信息如下
```bash
/C=CN/ST=Beijing/L=Beijing/O=Yunlu/OU=ops/CN=master1.doc.htyunlu.com/emailAddress=shanyou@htyunwang.com
# CN：Country Name
# ST: State or Province Name
# L: Locality(City)
# O: Organization Name or company Name
# OU: Organizational Unit Name or department name
# CN: Servername
# emailAddress: email for contact
```
签署证书命令
```bash
openssl req -x509 -new -nodes -key cakey.pem  -days 36500 -out cacrt.pem
```
签署后可以通过命令查询内容
```bash
# 查询 subject
openssl x509 -in cacert.pem -noout -subject
# 查询 有效期
openssl x509 -in cacert.pem -noout -dates
```
## 3. 为服务器生成SSL密钥
```bash
openssl genrsa -out registry.key 2048
```

## 4. 为服务器生成证书签署请求
```bash
openssl req -new -subj "/C=CN/ST=Beijing/L=Beijing/O=Yunlu/OU=ops/CN=registry.doc.htyunlu.com/emailAddress=shanyou@htyunwang.com" -key registry.key -out registry.csr
```
通过命令查询证书签署请求信息
```bash
#查询subj
openssl req -in registry.csr -subject -noout
```

## 5. 通过CA颁发证书
```bash
openssl x509 -req -in registry.csr -CA cacert.pem -CAkey cakey.pem -CAcreateserial -out registry.crt
```
这个签署给服务器的证书可以用来做https服务的证书

# 三、客户端如何信任证书并使用
如果使用的是`Centos7`的操作系统，需要把CA的根证书放在信任目录中，并更新，这样所有的该CA签署的证书都可以正常访问。在群集部署时可以用如下方法搞定。
```bash
ansible all -i test_hosts -m copy -a "src=registry/certs/cacert.pem dest='/etc/pki/ca-trust/source/anchors/cacert.pem'"
```
其中src是CA证书本地存储路径，dest是远程要存储的路径(在centos7中是定死了的)。运行完成后执行证书更新命令重启docker服务。
```bash
ansible all -i test_hosts -m command -a "update-ca-trust extract"
 ansible all -i test_hosts -m command -a "systemctl restart docker"
```
具体测试方法如下：
在没有复制CA根证书时通过命令访问时出错的。
```bash
curl https://registry.doc.htyunlu.com:5000/v2/_catalog
```
提示内容如下
```bash
curl: (60) Peer's Certificate issuer is not recognized.
More details here: http://curl.haxx.se/docs/sslcerts.html

curl performs SSL certificate verification by default, using a "bundle"
 of Certificate Authority (CA) public keys (CA certs). If the default
 bundle file isn't adequate, you can specify an alternate file
 using the --cacert option.
If this HTTPS server uses a certificate signed by a CA represented in
 the bundle, the certificate verification probably failed due to a
 problem with the certificate (it might be expired, or the name might
 not match the domain name in the URL).
If you'd like to turn off curl's verification of the certificate, use
 the -k (or --insecure) option.
```
如果复制CA根证书则会正常运行。结果如下
```bash
{"repositories":["registy"]}
```
# 高可用性群集ca证书制作方法
在测试环境里有三台机器同时提供api服务。通过keepalived进行高可用性
# 参考
[kubernetes Certificates](https://kubernetes.io/docs/concepts/cluster-administration/certificates/)
[基于OpenSSL自建CA和颁发SSL证书](http://seanlook.com/2015/01/18/openssl-self-sign-ca/)

[openssl rsa 使用简介](https://phpor.net/blog/post/445)

[openssl数字证书常见格式与协议介绍](https://blog.csdn.net/anxuegang/article/details/6157927)

[openssl查看证书细节](http://blog.51cto.com/colinzhouyj/1566250)

[私有安全docker registry授权访问实验](https://my.oschina.net/yyflyons/blog/656280)

[Add Root Certificates to a CentOS Linux Server](https://it.megocollector.com/tips-and-tricks/add-root-certificates-to-a-centos-linux-server/)
