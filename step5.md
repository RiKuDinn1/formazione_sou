# LABORATORIO 5
#
### Cosa ho utilizzato per questo laboratorio:
- VMWARE VirtualBox
- Rocky Linux & Ubuntu
- Apache WebServer
#
## 1. Installazione macchine virtuali
### FASE 1
   - Sul sito http://virtualbox.org ho scaricato VM Virtualbox per la virtualizzazione
  - Sul sito http://rockylinux.org ho installato la minimal iso di Rocky linux 9
  - Sul sito http://ubuntu.com ho installato la iso di Ubuntu 24.04
  - Sul sito https://www.debian.org/distrib/ ho installato la iso netinst di debian 12.5.0
  - Nella macchina virtuale ho installato gli appositi sistemi operativi seguendo le linee guida generali e le specifiche tecniche.
  - In previsione della fase 3 su virtualbox sono andato su Impostazioni/Rete/Rete NAT/ e ho impostato nome rete nat così da poter unire e far comunicare i due sistemi.
#
## 2. Comunicazione di rete tra macchine virtuali
### FASE 2
- Su Ubuntu ho utilizzato il comando `ip addr` così da visualizzare l'indirizzo ip della macchina e come risultato ho ottenuto "10.0.2.4/24".
- Su Rocky ho utilizzato il comando `ping 10.0.2.4 -c 3` così da pingare l'altro terminale con successo e con l'opzione `-c 3` ho evitato che ripetesse all'infinito il ping
#
## 3. Utilizzo di VM Apache WebServer
### FASE 3
- Sul terminale di Ubuntu ho utilizzato il `sudo apt update` e `sudo apt install apache2` per installare apache
- Sul terminale di Rocky invece ho utilizzato `sudo dnf install curl -y` per installare "curl" che servirà per contattare il webserver
#### FASE 3.1
- Sul terminale di Ubuntu ho utilizzato `sudo vi /etc/apache2/apache2.conf`. Nell'editor di testo ho cercato <Directory /var/www/> per poi modificarlo aggiungendo queste righe: 
```
  DocumentRoot /var/www/html
  <Directory /var/www/html>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
  </Directory> 
```  

- Dopo essere uscito dall'editor di testo sul terminale ho utilizzato <code>sudo vi /var/www/html/index.html</code> così da poter inserire l'intestazione "Hello DevOpsTribe!". a fine editor ho inserito queste righe:  

```html
  <!DOCTYPE html>
  <html>
  <head>
      <title> DevOpsTribe! </title>
    </head>
  <body>
       <h1> Hello DevOpsTribe! </h1>
  </body>
  </html>
```

#### FASE 3.2
- Dopo essere uscito e aver salvato gli editor di testo con il comando <code>sudo systemctl restart apache2</code> ho reinstartato apache.
- Su Ubuntu ho attuato due controlli: uno in CLI ed uno in GUI
  1. Nella GUI sono andato sul browser digitando http://localhost così da controllare se funzionasse la pagina con il messaggio
  2. Su CLI ho digitato <code>curl http://localhost</code>
- Dopo aver controllato che tutto andasse ho aperto il file di configurazione del firewall per abilitare la porta 80 di default con <code>sudo ufw allow 80</code>
#### FASE 3.3
- Su Rocky ho utilizzato il comando <code>curl http://10.0.2.4</code> così da visualizzare la parola scritta nell'apache di Ubuntu.

### Esercizio extra: Inserire e abilitare la porta 8080
- Su Ubuntu ho utilizzato il comando <code>sudo vi /etc/apache2/ports.conf</code>. Nell'editor ho inserito <code>Listen 8080</code>
- Dopo aver salvato sul terminale ho utilizzato il comando <code>sudo ufw allow 8080</code> per abilitare la porta 8080.



