# Exercise Vagrant ping pong
> [!IMPORTANT]
> Questo esercizio è svolto interamente da terminale MacOS(linux like).
# 
### Cosa ho utilizzato per questo esercizio:
- Vagrant
- Docker
- NodeJS
#
## 1. Installazione Vagrant
### Installazione su MacOS
- Ho utilizzato il comando <code>brew install vagrant</code>
### Installazione su distribuzioni RedHat
- Aggiorniamo il sistema con <code>sudo dnf update -y</code>.
- Installiamo le dipendenze <code>sudo dnf install -y dnf-plugins-core</code>.
- Aggiungiamo il repository <code>sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo</code>.
- Installiamo Vagrant con <code>sudo dnf install -y vagrant</code>.
### Installazione su distribuzioni Debian
- Aggiorniamo il sistema con <code>sudo apt upgrade -y</code>.
- Installiamo le dipendenze ```curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"```
- Installiamo vagrant:
<code>sudo apt update</code>
<code>sudo apt install -y vagrant</code>
#
## 2. Configurazione Vagrant
### Creazione directory e inizializzazione
- Per la creazione della directory useremo il comando <code>mkdir Vagrantpingpong</code>.
- Visto che dobbiamo lavorare sulla directory ci sposteremo su di essa con il comando <code>cd Vagrantpingpong</code>.
#
## 3. Inizializzazione, modifica e avvio di Vagrant
### FASE 1
- Per inizializzare Vagrant useremo il comando <code>vagrant init</code>. Se ha funzionato ci ritroveremo un file chiamato "Vagrantfile".
- Per modificare il file generato useremo <code>vi Vagrantfile</code>. All'interno non troveremo il file vuoto e per questo tenendo premuto il tasto "d" lo svuoteremo completamente.
### FASE 1.2
- In questo file configureremo Vagrant:
```
Vagrant.configure("2") do |config|

  # Definire le macchine virtuali
  config.vm.define "node1" do |node|
    node.box = "ubuntu/xenial64"

    # Installare Docker con lo script
    node.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker.io
    SHELL

    # Configurazione di Docker per l'esecuzione senza sudo
    node.provision "shell", inline: <<-SHELL
      groupadd docker
      usermod -aG docker $USER
    SHELL
  end

  config.vm.define "node2" do |node|
    node.box = "ubuntu/xenial64"

    
    node.provision "shell", inline: <<-SHELL
      apt-get update && apt-get install -y docker.io
    SHELL

    
    node.provision "shell", inline: <<-SHELL
      groupadd docker
      usermod -aG docker $USER
    SHELL
  end

  # Sincronizzare la cartella del progetto con entrambi i nodi
  config.vm.provision "shell", inline: <<-SHELL
    mkdir -p /vagrant
    mount -t vboxsf Vagrantpingpong /vagrant
  SHELL

  # Script per l'esecuzione del container NodeJS
  config.vm.provision "shell", inline: <<-SHELL
    #!/bin/bash

    set -e

    # Copiare il file package.json e il file server.js nella cartella home dell'utente
    cp /vagrant/package.json ~
    cp /vagrant/server.js ~

    # Installare le dipendenze di NodeJS
    npm install

    # Eseguire il container NodeJS
    docker run -d -p 3000:3000 --name nodejs-app nodejs:latest node server.js
  SHELL

  # Migrazione del container ogni 60 secondi
  config.vm.provision "shell", inline: <<-SHELL
    #!/bin/bash

    set -e

    while true; do
      # Ottenere l'indirizzo IP del nodo corrente
      CURRENT_IP=$(ip addr | grep 'inet ' | awk '{ print $2 }' | sed 's/:/ /g' | awk '{ print $1 }')

      # Ottenere l'indirizzo IP dell'altro nodo
      if [ "$CURRENT_IP" == "$(config.vm.get("node1", "ip_address"))" ]; then
        OTHER_NODE_IP=$(config.vm.get("node2", "ip_address"))
      else
        OTHER_NODE_IP=$(config.vm.get("node1", "ip_address"))
      fi

      # Controllare se il container è in esecuzione
      if docker ps | grep -q nodejs-app; then
        # Arrestare e rimuovere il container
        docker rm -f  nodejs-app

        # Eseguire il container sul nodo opposto
        ssh vagrant@$OTHER_NODE_IP "docker run -d -p 3000:3000 --name nodejs-app nodejs:latest node server.js"
      fi

      sleep 60
    done
  SHELL
end
```
### FASE 1.2
- Dopo aver salvato il "Vagrantfile" dobbiamo creare il file package.json con <code>sudo vi package.json</code> e all'interno inserire:
```
  {
  "name": "node-ping-pong",
  "version": "1.0.0",
  "description": "Esempio di applicazione NodeJS per Vagrant",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
```
### FASE 1.3
- Per avviare Vagrant useremo il comando <code>vagrant up</code>.
- Per controllare gli indirizzi ip dei nodi faremo <code>vagrant ssh-config node1</code> o <code>vagrant ssh-config node2</code> e andando sul browser digitando http://<IndirizzoIpNodo>:3030" controlleremo che tutto sia funzionante.


