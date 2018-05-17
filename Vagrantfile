BOX_NAME = "centos/7"

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.cpus   = "2"
    vb.memory = "2048"
  end

  # kube node 'A'
  config.vm.define :node_a do |node_a|
    node_a.vm.hostname = "node-a"
    node_a.vm.box = BOX_NAME
    node_a.vm.provision 'shell', path: 'provision.sh'
    node_a.vm.network :private_network, ip: '192.168.99.200'
    # vagrant@vagrant:~$ ip addr show | grep 'inet 192.168.99'
    # inet 192.168.99.200/24 brd 192.168.99.255 scope global eth1
  end

  # kube node 'B'
  config.vm.define :node_b do |node_b|
    node_b.vm.hostname = "node-b"
    node_b.vm.box = BOX_NAME
    node_b.vm.provision 'shell', path: 'provision.sh'
    node_b.vm.network :private_network, ip: '192.168.99.202'
    # ip addr show | grep 'inet 192.168.99'
    # inet 192.168.99.202/24 brd 192.168.99.255 scope global eth1
  end
end

# On node A:
# sudo kubeadm init --apiserver-advertise-address 192.168.99.200 --pod-network-cidr=192.168.99.0/16
# note: copy down discovery token / kubeadm join command for later
# if you lose it, run:
# sudo kubeadm token create --print-join-command
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config
# export KUBECONFIG=$HOME/.kube/config

# kubectl apply -f \
# https://docs.projectcalico.org/v3.1/getting-started/kubernetes/installation/hosted/kubeadm/1.7/calico.yaml

# watch kubectl get pods --all-namespaces
# should see all pods running

# kubectl get nodes
# should see:
# NAME      STATUS    ROLES     AGE       VERSION
# vagrant   Ready     master    6m        v1.9.7

# On node B:
# sudo kubeadm join --token ${token} 192.168.99.200:6443 --discovery-token-ca-cert-hash ${discovery_token}

# On node A:
# kubectl get nodes
# output should look like this:
# NAME      STATUS    ROLES     AGE       VERSION
# node-a    Ready     master    3m        v1.9.7
# node-b    Ready     <none>    45s       v1.9.7


# restart commands:
# systemctl daemon-reload && systemctl restart kubelet docker