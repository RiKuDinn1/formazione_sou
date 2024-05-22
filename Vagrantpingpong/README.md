# Exercise Vagrant ping pong
> [!IMPORTANT]
> This exercise is done entirely from a MacOS (linux like) terminal.
# 
### What I used for this exercise:
- Vagrant
- Docker
- NodeJS
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

  # Define virtual machines
  config.vm.define "node1" do |node|
    node.vm.box = "ubuntu/xenial64"

    # Install Docker with the script
    node.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker.io
    SHELL

    # Configure Docker to run without sudo
    node.vm.provision "shell", inline: <<-SHELL
      groupadd docker
      usermod -aG docker $USER
    SHELL
  end

  config.vm.define "node2" do |node|
    node.vm.box = "ubuntu/xenial64"

    
    node.vm.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker.io
    SHELL

    
    node.vm.provision "shell", inline: <<-SHELL
      groupadd docker
      usermod -aG docker $USER
    SHELL
  end

  # Synchronize the project folder with both nodes
  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /vagrant
    mount -t vboxsf Vagrantpingpong /vagrant
  SHELL

  # Script for running the NodeJS container
  config.vm.provision "shell", inline: <<-SHELL
    #!/bin/bash

    set -e

    # Copy the package.json and server.js file to the user's home folder
    cp /vagrant/package.json ~
    cp /vagrant/server.js ~

    # Install NodeJS dependencies
    npm install

    # Run the NodeJS container
    docker run -d -p 3000:3000 --name nodejs-app nodejs:latest node server.js
  SHELL

  # Migrate the container every 60 seconds
  config.vm.provision "shell", inline: <<-SHELL
    #!/bin/bash

    set -e

    while true; do
      # Get the IP address of the current node
      CURRENT_IP=$(ip addr | grep 'inet ' | awk '{ print $2 }' | sed 's/:/ /g' | awk '{ print $1 }')

      # Get the IP address of the other node
      if [ "$CURRENT_IP" == "$(config.vm.get("node1", "ip_address"))" ]; then
        OTHER_NODE_IP=$(config.vm.get("node2", "ip_address"))
      else
        OTHER_NODE_IP=$(config.vm.get("node1", "ip_address"))
      fi

      # Check if the container is running
      if docker ps | grep -q nodejs-app; then
        # Arrestare e rimuovere il container
        docker rm -f  nodejs-app

        # Run the container on the opposite node
        ssh vagrant@$OTHER_NODE_IP "docker run -d -p 3000:3000 --name nodejs-app nodejs:latest node server.js"
      fi

      sleep 60
    done
  SHELL
end
```
### PHASE 1.2
- After saving the "Vagrantfile" we must create the package.json file with <code>sudo vi package.json</code> and insert:
```
  {
  "name": "node-ping-pong",
  "version": "1.0.0",
  "description": "NodeJS application example for Vagrant",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
```
### PHASE 1.3
- To start Vagrant we will use the <code>vagrant up</code> command.
- To check the IP addresses of the nodes we will do <code>vagrant ssh-config node1</code> or <code>vagrant ssh-config node2</code> and by going to the browser typing http://<NodeIpAddress>:3030" we will check that everything is working.


