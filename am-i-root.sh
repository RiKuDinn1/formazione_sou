#!/bin/bash
# am-i-root.sh: Sono root o no?

# Imposta l'UID di root
ROOT_UID=0  # L'utente root ha $UID 0.

# Controlla se l'utente corrente è root
if [ "$UID" -eq "$ROOT_UID" ]  # È il vero "root" a farsi avanti?
then
  echo "Sei root."
else
  echo "Sei solo un utente normale (ma la mamma ti vuole bene lo stesso)."
fi

# Termina lo script con codice di uscita 0
exit 0

# ============================================================= #
# Il codice seguente non verrà eseguito perché lo script è già terminato.

# Metodo alternativo per verificare i privilegi di root
ROOTUSER_NAME=root

# Recupera il nome utente corrente
username=`id -nu`     # Oppure... username=`whoami`

# Controlla se l'utente corrente è root usando il nome utente
if [ "$username" = "$ROOTUSER_NAME" ]
then
  echo "Rooty, toot, toot. Sei root."
else
  echo "Sei solo un utente normale."
fi
