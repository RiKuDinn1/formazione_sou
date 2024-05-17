# Creazione di un WebServer con Vagrant
#
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
