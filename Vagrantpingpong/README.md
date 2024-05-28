# Exercise Vagrant ping pong
> [!IMPORTANT]
> This exercise is done entirely from a MacOS (Unix like) terminal.
# 
### What I used for this exercise:
- Vagrant
- Docker
- ealen/echo-server
#
## 1. Vagrant installation
### Installation on MacOS distributions
- I use the command <code>brew install vagrant</code>
### Installation on RedHat distributions
- Update the system with <code>sudo dnf update -y</code>.
- Install the dependencies <code>sudo dnf install -y dnf-plugins-core</code>.
- Add the repository <code>sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo</code>.
- Install Vagrant with <code>sudo dnf install -y vagrant</code>.
### Installation on Debian distributions
- Update the system with <code>sudo apt upgrade -y</code>.
- Install the dependencies ```curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"```
- Install Vagrant:
<code>sudo apt update</code>
<code>sudo apt install -y vagrant</code>
#
## 2. Vagrant configuration
### Directory creation and initialization
- To create the directory we will use the command <code>mkdir Vagrantpingpong</code>.
- Since we need to work on the directory we will move to it with the command <code>cd Vagrantpingpong</code>.
#
## 3. Vagrant initialization, modification and start
### PHASE 1
- To initialize Vagrant we will use the command <code>vagrant init</code>. If it worked we will find a file called "Vagrantfile".
- To modify the generated file we will use <code>vi Vagrantfile</code>. Inside we will not find the empty file and for this by holding down the "d" key we will empty it completely.
### PHASE 1.2
- In this file we will configure Vagrant:
```
Vagrant.configure("2") do |config|
config.ssh.insert_key = false
config.ssh.private_key_path = ['~/.vagrant.d/insecure_private_key', '~/.ss    h/id_rsa']
config.vm.provision "file", source: "~/.ssh/id_rsa.pub", destination: "~/.    ssh/authorized_keys"
# Define node1
  config.vm.define "node1" do |node1|
    node1.vm.box = "ubuntu/bionic64"
    node1.vm.network "private_network", ip: "192.168.30.10"
    node1.vm.provision "shell", path: "provision-node1.sh"
   end
 
# Define node2
  config.vm.define "node2" do |node2|
    node2.vm.box = "ubuntu/bionic64"
    node2.vm.network "private_network", ip: "192.168.30.20"
    node2.vm.provision "shell", path: "provision-node2.sh"
   end
end

```
### PHASE 1.2
- After saving the "Vagrantfile" we must create the provision node file 1 and 2 with <code>sudo vi provision-node1.sh</code> and <code>sudo vi provision-node2.sh</code>. insert:
```
 #!/bin/bash

# Installiamo docker e curl
sudo apt-get update
sudo apt-get install -y docker.io
sudo apt-get install curl

# Startiamo docker e pulliamo l'immagine del container
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull ealen/echo-server

# Crea un nuovo utente chiamato "nomeutente"
sudo adduser riku

# Aggiungi l'utente al gruppo "sudo" per i privilegi di root
sudo usermod -aG sudo,docker riku

```
### PHASE 1.3
- we create the migration.sh script to start the migration between the two nodes every 60 seconds:

```
#!/bin/bash

# IPs dei nodi
NODE1_IP="192.168.30.10"
NODE2_IP="192.168.30.20"

# Nome del container
CONTAINER_NAME="ealen-container"

# Comando per avviare il container
ssh riku@$NODE1_IP "docker run -d -p 3000:80 --name $CONTAINER_NAME ealen/echo-server"
while true; do
  # Verifica se il container è in esecuzione su node1
  ssh riku@$NODE1_IP "docker ps | grep $CONTAINER_NAME"

        if curl 192.168.30.10:3000 ;  then

                # Arresta il container su node1
                ssh riku@$NODE1_IP "docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME"
                # Avvia il container su node
                ssh riku@$NODE2_IP "docker run -d -p 3000:80 --name $CONTAINER_NAME ealen/echo-server"

        else

                # Arresta il container su node2
                ssh riku@$NODE2_IP "docker stop $CONTAINER_NAME && docker rm $CONTAINER_NAME"
                # Avvia il container su node1
                ssh riku@$NODE1_IP "docker run -d -p 3000:80 --name $CONTAINER_NAME ealen/echo-server"
        fi
            # Attende 60 secondi prima di migrare di nuovo
            sleep 60
done
```

### PHASE 1.4
- To start Vagrant we will use the <code>vagrant up</code> command.
- After starting the migration script with <code>sh migration.sh</code> we will notice how every 60 seconds one node at a time will create, stop and destroy its container to start it on the other node


