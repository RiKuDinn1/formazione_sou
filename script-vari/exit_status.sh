#!/bin/bash

echo "hello"
echo "$?"  # Stato di uscita 0 (il comando è stato eseguito con successo).

lskdf  # Comando sconosciuto (non riconosciuto dal sistema).
echo "$?"  # Stato di uscita diverso da 0 (il comando non è stato eseguito correttamente).

echo

exit 113  # Lo script uscirà con lo stato di uscita 113.
          # Puoi verificarlo digitando "echo $?" dopo la terminazione dello script.

# Convenzioni sugli stati di uscita:
#  - exit 0 indica generalmente un'esecuzione riuscita.
#  - Un valore di uscita diverso da 0 indica spesso un errore o una condizione anomala.
#  - Puoi consultare l'appendice "Codici di uscita con significati speciali" per dettagli su codici specifici (potrebbe essere necessario cercarla online).
