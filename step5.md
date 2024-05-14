# LABORATORIO 5
### 1. Installazione macchine virtuali
### 2. Comunicazione di rete tra macchine virtuali
### 3. Utilizzo di VM Apache WebServer
#
### Cosa ho utilizzato per questo laboratorio:
- VMWARE VirtualBox
- Rocky Linux & Ubuntu
- Apache WebServer
  #
  ### FASE 1
   - Sul sito http://virtualbox.org ho scaricato VM Virtualbox per la virtualizzazione
  - Sul sito http://rockylinux.org ho installato la minimal iso di Rocky linux 9
  - Sul sito http://ubuntu.com ho installato la iso di Ubuntu 24.04
  - Nella macchina virtuale ho installato gli appositi sistemi operativi seguendo le linee guida generali e le specifiche tecniche.
  - Per attuare la fase 3 correttamente sulla virtualbox sono andato su Impostazioni/Rete/Rete NAT/impostato nome rete nat così da poter unire e far comunicare i due sistemi.
#
### FASE 2
- Su ubuntu ho utilizzato il comando `ip addr` così da visualizzare l'indirizzo ip della macchina e come risultato ho ottenuto "10.0.2.4/24".
- Su Rocky ho utilizzato il comando `ping 10.0.2.4 -c 3` così da pingare l'altro terminale con successo e con l'opzione `-c 3` ho evitato che ripetesse all'infinito il ping

#
### FASE 3ß
- Sul terminale di ubuntu ho utilizzato il sudo apt update    
sudo apt install apache2‘
