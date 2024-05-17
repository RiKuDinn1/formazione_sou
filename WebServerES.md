# Creazione di un WebServer con Vagrant

#### N.B Stiamo lavorando su un terminale MacOS(Unix-like) e con il pacchetto HomeBrew
#
### Cosa ho utilizzato per questo laboratorio:
- VirtualBox
- Vagrant
#
## 1. Installazione di Virtualbox e Vagrant
### FASE 1
- Per l'installazione di Virtualbox sul terminale digitare <code>brew update; brew install virtualbox</code>.
- Per l'installazione di Vagrant sul terminale digitare <code>brew install vagrant</code>.
#
## 2. Creazione della directory per il WebServer
### FASE 2
- Per la creazione della directory useremo il comando <code>mkdir VagrantWebServer</code>
- Visto che dobbiamo lavorare sulla directory ci sposteremo su di essa con il comando <code> cd VagrantWebServer</code>
#
## 3. Inizializzazione, modifica e avvio di Vagrant
### FASE 3
- Per inizializzare Vagrant useremo il comando <code>vagrant init</code>. Se ha funzionato ci ritroveremo un file chiamato "Vagrantfile".
- Per modificare il file generato useremo <code>vi Vagrantfile</code>. All'interno non troveremo il file vuoto e per questo tenendo premuto il tasto "d"
lo svuoteremo completamente.
### FASE 3.1
- In questo file configureremo Vagrant
```
# Vagrantfile

Vagrant.configure("2") do |config|
  # Specifica la box che stiamo utilizzando(In questo caso ubuntu/bionic64)
  config.vm.box = "ubuntu/bionic64"
  
  # Forwarding della porta 80 della MV alla porta 8081 dell'host
  config.vm.network "forwarded_port", guest: 80, host: 8081
  
  # Configurazione delle risorse della VM
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
```
- Per automatizzare il procedimento realizzeremo un piccolo script sempre all'interno di "Vagrantfile".
  ```
  # Script di provisioning utilizzando il provisioner shell
  config.vm.provision "shell", inline: <<-SHELL
    # Aggiorna la lista dei pacchetti e installa Nginx
    apt-get update
    apt-get install -y nginx
    
    # Rimuove la pagina di benvenuto di default di Nginx
    rm /var/www/html/index.nginx-debian.html
    
    # Crea una pagina HTML personalizzata
    echo '<!DOCTYPE html>
    <html>
    <head>
        <title>Benvenuto nel Webserver di Riku</title>
    </head>
    <body>
        <h1>Benvenuto visitatore!</h1>
        <p>Questo è un server di prova.</p>
    </body>
    </html>' > /var/www/html/index.html
    
    # Riavvia Nginx per applicare le modifiche
    systemctl restart nginx
   SHELL
   end
  ```
  ### FASE 3.2
  - Per avviare Vagrant useremo il comando <code>vagrant up</code>.
  - Se tutto è funzionante quando andremo sul browser e digiteremo http://localhost:8081 troveremo il messaggio modificato in html.
  - Per stoppare Vagrant utilizzeremo il comando <code>Vagrant halt</code>. Per eliminarlo <code>vagrant destroy</code>.
  
