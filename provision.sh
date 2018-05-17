#!/bin/sh
set -ex

yum update && yum install -y curl
yum install -y docker

systemctl enable docker && systemctl start docker

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl kubeadm

systemctl enable kubelet && systemctl start kubelet
swapoff -a
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

export KUBECONFIG=/etc/kubernetes/admin.conf
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/bash.bashrc
# sudo -i
# /vagrant/bin/594_kubeadm init
# kubectl apply -f https://git.io/weave-kube-1.6
# kubectl taint nodes --all node-role.kubernetes.io/master- 