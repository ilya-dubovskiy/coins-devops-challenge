# coins-devops-challenge
Test challenge for coins.ph

---

## how to deploy everything to a local machine:

#### Prerequisites:

- Ubuntu 16.04
- No containers running (ansible includes docker prune commands)
- sudoer

#### 1. install ansible with required modules

```
sudo apt-get install -y software-properties-common &&
sudo apt-add-repository ppa:ansible/ansible &&
sudo apt-get update &&
sudo apt-get install -y ansible python-pip
sudo pip install openshift --ignore-installed
```

#### 2. run full stack locally (minikube + backend + database + nginx)

```
git clone https://github.com/ilya-dubovskiy/coins-devops-challenge.git
cd coins-devops-challenge/ansible
sudo ansible-playbook -i inventory -c local full.yml
```

#### 3. In order to start using the todo app, login to <hostname>/gtdadmin/ and create groups, users, etc

## Points to improve in the setup:

#### 1. Docker:

- /app dir should be mounted to the container
- docker should not be build on every deployment `RUN git clone` outside of container
- todo app is installed with `RUN pip install django django-todo`,
in a normal workflow it makes sense to download from git (in case we need branches)
- `COPY conf/local.py /app/gtd/project/local.py` should be mounted-in, not hardcoded in image,
- default user/database is used, makes sense to create/manage those separately
```
'NAME': 'postgres',
'USER': 'postgres',
'PASSWORD': 'postgres',
'HOST': 'localhost',
```

- email functionality not tested
- security:
`ALLOWED_HOSTS = ['*']`

- debug info
```
cd /app/gtd/
ls -la ./
pwd
python -V
```

#### 2. Kubernetes deploy:

- `hostNetwork: true` used to speed things up (to not manage kubernetes dns and ports)
- ansible vault should be used for this:
```
- name: POSTGRES_PASSWORD
value: "postgres"
- name: POSTGRES_USER
value: "postgres"
```
- `namespace: default` namespace creation was moved outside of the scope.
- docker image is build and located locally to skip creation of secrets in kubernetes and additional system in the cycle (docker registry)
- minikube runs as root

#### 3. Ansible:

- 3rd-party roles should be moved to gitmodules
- code below can harm other containers
```
- name: remove all the old crap
  command: docker system prune -a -f
  become: yes
```

