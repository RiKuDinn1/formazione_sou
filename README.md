# Appunti
## Modificare la variabile PATH in modo permanente
``
#Uso l'editor di testo per entrare in bashrc
vi ~/.bashrc

#Dentro bashrc con export creiamo una nuova variabile d'ambiente permanente
export PATH=$PATH:/usr/local/bin:/home/user/bin
export MY_VAR="my value"
``


