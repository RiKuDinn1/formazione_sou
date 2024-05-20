# Cambia directory in /var/log
cd /var/log

# Pulisce il contenuto del file di registro messages
cat /dev/null > messages  # Reindirizza dati nulli al file messages, pulendolo effettivamente

# Pulisce il contenuto del file di registro wtmp
cat /dev/null > wtmp  # Reindirizza dati nulli al file wtmp, pulendolo effettivamente

# Stampa un messaggio che indica la pulizia riuscita dei file di registro
echo "File di registro puliti."
