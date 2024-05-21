#!/bin/bash4

# fetch_address.sh

# Dichiara un array associativo chiamato "address"
declare -A address

# -A indica che stiamo dichiarando un array associativo
# Gli array associativi memorizzano valori utilizzando chiavi (nomi) arbitrarie

# Aggiunge elementi all'array associativo
address[Charles]="414 W. 10th Ave., Baltimore, MD 21236"
address[John]="202 E. 3rd St., New York, NY 10009"
address[Wilma]="1854 Vermont Ave, Los Angeles, CA 90023"

# Stampa gli indirizzi utilizzando le chiavi dell'array
echo "Charles's address is ${address[Charles]}."
echo "Wilma's address is ${address[Wilma]}."
echo "John's address is ${address[John]}."

echo

# Stampa le chiavi (nomi) dell'array
echo "${!address[@]}"  # Stampa gli indici dell'array (le chiavi)
# Charles John Wilma
