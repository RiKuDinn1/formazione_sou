# Appunti
### Modificare la variabile PATH in modo permanente
<code>#Uso l'editor di testo per entrare in bashrc
vi ~/.bashrc

#Dentro bashrc con export creiamo una nuova variabile d'ambiente permanente
export PATH=$PATH:/usr/local/bin:/home/user/bin
export MY_VAR="my value"
</code>

### Modificare la variabile PATH in modo temporaneo
<code> #Passo alla directory home con Change Directory
cd Home

#Nella directory home creo una nuova directory chiamata "Scripting"
mkdir Scripting

#Nuovamente con cd passo alla directory appena creata
cd Scripting

#Usando l'editor di testo creo uno script .sh
vi prova.sh

#Con questo comando sto modificando la variabile d'ambiente in modo temporaneo
export PATH=$PATH:/Home/Scripting

#Controllo se la variabile d'ambiente è stata aggiunta correttamente
ubuntu@primary:~/Home/Scripting$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/Home/Scripting </code>


