k8s中的证书服务
===
k8s中的很多服务需要通过TLS来支持。

生成的 CA 证书和秘钥文件如下：

* ca-key.pem
* ca.pem
* kubernetes-key.pem
* kubernetes.pem
* kube-proxy.pem
* kube-proxy-key.pem
* admin.pem
* admin-key.pem

使用证书的组件如下：

etcd：使用 ca.pem、kubernetes-key.pem、kubernetes.pem；

kube-apiserver：使用 ca.pem、kubernetes-key.pem、kubernetes.pem；

kubelet：使用 ca.pem；

kube-proxy：使用 ca.pem、kube-proxy-key.pem、kube-proxy.pem；

kubectl：使用 ca.pem、admin-key.pem、admin.pem；

`kube-controller`、`kube-scheduler` 当前需要和 `kube-apiserver` 部署在同一台机器上且使用非安全端口通信，故不需要证书。

生成证书的方法请参考 [CA.md](CA.md)
# 云路CA证书的规范
所有的证书`Subject`规范如下
```bash
C=CN, ST=Beijing, L=Beijing, O=Yunlu, OU=ops, CN=<SerivceName>/emailAddress=shanyou@htyunwang.com
```
其中
> * "CN"：Common Name，kube-apiserver 从证书中提取该字段作为请求的用户名 (User Name)；浏览器使用该字段验证网站是否合法；
> * "O"：Organization，kube-apiserver 从证书中提取该字段作为请求用户所属的组 (Group)；
# Reference
* [创建TLS证书和秘钥](https://jimmysong.io/kubernetes-handbook/practice/create-tls-and-secret-key.html)
* [kubernetes Certificates](https://kubernetes.io/docs/concepts/cluster-administration/certificates/)
* [Kubernentes中的身份验证](https://jimmysong.io/posts/kubernetes-tls-certificate/)
* [follow-me-install-kubernetes-cluster](https://github.com/opsnull/follow-me-install-kubernetes-cluster)
* [k8s部署之使用CFSSL创建证书](http://www.simlinux.com/2017/09/07/k8s-cfssl-install-cert.html)
* [Kubernetes安装之证书验证](https://jimmysong.io/posts/kubernetes-tls-certificate/)
