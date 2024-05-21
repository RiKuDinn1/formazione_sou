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


