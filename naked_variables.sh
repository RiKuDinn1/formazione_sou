#!/bin/bash
# Variabili nude

echo

# Quando una variabile è "nuda", ovvero senza il '$' davanti?
# Quando viene assegnato un valore, piuttosto che richiamato.

# Assegnazione
a=879
echo "Il valore di \"a\" è $a."

# Assegnazione usando 'let'
let a=16+5
echo "Il valore di \"a\" ora è $a."

echo

# In un ciclo 'for' (in realtà è un tipo di assegnazione mascherata):
echo -n "I valori di \"a\" nel ciclo sono: "
for a in 7 8 9 11
do
  echo -n "$a "
done

echo
echo

# In un comando 'read' (anche un tipo di assegnazione):
echo -n "Inserisci un valore per \"a\" "
read a
echo "Il valore di \"a\" ora è $a."

echo

exit 0
