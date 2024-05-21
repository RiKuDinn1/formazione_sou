#!/bin/bash
# progress-bar2.sh

# Richiede Bash per funzionare, non compatibile con sh.

intervallo=1
intervallo_lungo=10

{   # Inizia un processo in background che gestisce la barra di avanzamento
  trap "exit" SIGUSR1  # Intercetta il segnale SIGUSR1 per terminare il processo
  sleep $intervallo; sleep $intervallo
  while true  # Ciclo infinito
  do
    echo -n '.'  # Stampa un punto senza andare a capo
    sleep $intervallo
  done; } &  # Esecuzione in background

pid=$!  # Recupera l'ID del processo in background

trap "echo !; kill -USR1 $pid; wait $pid" EXIT  # Gestisce il segnale Ctrl+C (SIGINT)
  # - echo !: stampa il carattere di negazione (!)
  # - kill -USR1 $pid: invia il segnale SIGUSR1 al processo con ID $pid
  # - wait $pid: attende la terminazione del processo con ID $pid

echo -n 'Processo lungo in esecuzione '
sleep $intervallo_lungo
echo ' Terminato!'

kill -USR1 $pid  # Invia il segnale SIGUSR1 al processo in background per fermarlo
wait $pid         # Attende la terminazione del processo in background

trap EXIT        # Ripristina il comportamento predefinito per Ctrl+C

exit $?          # Esce dallo script con lo stesso codice di uscita del processo lungo
