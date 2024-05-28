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

