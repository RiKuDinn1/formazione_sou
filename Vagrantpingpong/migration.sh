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
