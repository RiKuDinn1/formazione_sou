#!/bin/bash

# Questo script richiede almeno 10 parametri per essere eseguito, ad esempio:
# ./nome_script 1 2 3 4 5 6 7 8 9 10
MIN_PARAMETRI=10  # Numero minimo di parametri richiesti

echo

# Stampa il nome completo dello script
echo "Il nome completo di questo script è \"$0\"."
# Aggiunge ./ per la directory corrente
echo "Il nome dello script è \"`basename $0`\"."  # Estrae solo il nome (basename)

echo

# Controlla se il primo parametro è presente e non vuoto
if [ -n "$1" ]  # Controlla se la variabile $1 è impostata e non vuota
then
  echo "Il parametro #1 è $1"  # Stampa il valore del primo parametro
fi

# Controlla singolarmente i parametri da #2 a #10
if [ -n "$2" ]
then
  echo "Il parametro #2 è $2"
fi

if [ -n "$3" ]
then
  echo "Il parametro #3 è $3"
fi

# ... (ripetere per i parametri rimanenti fino a #10)

# Controlla se il decimo parametro è presente e non vuoto (necessarie parentesi graffe)
if [ -n "${10}" ]  # Le parentesi graffe sono obbligatorie per parametri oltre il #9
then
  echo "Il parametro #10 è ${10}"
fi

echo "-----------------------------------"
# Stampa tutti i parametri forniti
echo "Tutti i parametri della riga di comando sono: \"$*\"."

# Controlla se il numero di parametri forniti è inferiore al minimo richiesto
if [ $# -lt "$MIN_PARAMETRI" ]
then
  echo
  echo "Questo script richiede almeno $MIN_PARAMETRI argomenti dalla riga di comando!"
fi

echo

exit 0
