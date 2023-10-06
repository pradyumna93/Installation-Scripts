#Update the System:

#First, update your Ubuntu system to ensure you have the latest packages:
sudo apt update
sudo apt upgrade -y

#Install Docker:

#Kubernetes relies on Docker for containerization. Install Docker by running:

sudo apt install docker.io -y
#After installation, start and enable the Docker service:

sudo systemctl start docker
sudo systemctl enable docker
Install kubeadm, kubelet, and kubectl:

#Install the Kubernetes components by adding the official Kubernetes APT repository:

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

#Initialize the Kubernetes Cluster:

#On the VM that you want to use as the master node, run the following command to initialize the cluster:


sudo kubeadm init
#Note that this command will generate a command with a token to join worker nodes to the cluster. Save this command as you will need it later to add worker nodes.

#Set Up kubectl for the Current User:

#After initializing the cluster, set up kubectl for your user:

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#Deploy a Pod Network (CNI):

#Kubernetes requires a Pod network for communication between Pods and nodes. You can choose from various CNI plugins. One common choice is Calico:

kubectl apply -f https://docs.projectcalico.org/v3.18/manifests/calico.yaml
#or
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.1/manifests/calico.yaml 
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.49.0/deploy/static/provider/baremetal/deploy.yaml

#Join Worker Nodes (Optional):

#If you have worker nodes that you want to add to the cluster, use the token generated during the cluster initialization. Run the command on the worker nodes:

sudo kubeadm join <master-node-ip>:<master-node-port> --token <token> --discovery-token-ca-cert-hash <ca-cert-hash>
#Replace <master-node-ip>, <master-node-port>, <token>, and <ca-cert-hash> with the values from the kubeadm init output.

#Verify Cluster Status:

#On the master node, run the following command to check the status of the cluster:


kubectl get nodes
#You should see the master node in the "Ready" state. Worker nodes, if added, should also be listed.
