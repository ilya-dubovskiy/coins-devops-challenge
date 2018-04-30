# coins-devops-challenge
Test challenge for coins.ph

---

how to deploy everything to a local machine:

prerequisites: Ubuntu 16.04 with no containers running

1. install ansible

sudo apt-get install -y software-properties-common &&
sudo apt-add-repository ppa:ansible/ansible &&
sudo apt-get update &&
sudo apt-get install -y ansible python-pip

sudo pip install openshift --ignore-installed

2. run full stack locally (minikube + backend + database + nginx)

git clone https://github.com/ilya-dubovskiy/coins-devops-challenge.git
cd coins-devops-challenge/ansible

sudo ansible-playbook -i inventory -c local full.yml

3. In order to start using the todo app, login to <hostname>/gtdadmin/ and create groups, users, etc
