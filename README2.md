-lt == less than
-gt == greater than

if () --> start
fi --> end

=======================================================
Day-3
== 
!=
>=
<=
=================if-condition=================
if [$a == $b]
then
echo "abcd"
else
echo "efgh"
fi
#if is written in brackets and always if statement must be closed with fi.

if we are using <=, >= then we have to keep it in (()) ==> Double brackets
if we are using -lt, -gt then we have to keep it in [] => single brackets

#htop -->> will show utilization

#Create a slack channgel and intergrate webhooks
## Slack Integration for Memory Alerts

To receive system alerts in Slack:

1. **Create a Slack channel** where you want alerts to appear.
2. Go to **Slack → Settings → Integrations → Incoming Webhooks** and generate a webhook URL.
3. Copy the webhook URL and store it in an environment variable, e.g. `SLACK_WEB`.

### Triggering Memory Utilization Alerts
Use a simple Bash script to check memory and post to Slack:

```bash
#!/bin/bash
AVAILABLE_MEM=$(free -m | awk '/Mem:/ {print $7}')
TOTAL_MEM=$(free -m | awk '/Mem:/ {print $2}')
HOST=$(hostname -I | awk '{print $1}')

curl -X POST -H 'Content-type: application/json' \
--data "{\"text\":\"Alert: Memory low on $HOST. Only $AVAILABLE_MEM MB free out of $TOTAL_MEM MB.\"}" \
$SLACK_WEB


=================EC2- Metada=====================
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

==============contab==============
To run your desired script every 5 minutes
*/5 * * * * /home/ec2-user/memory_alert.sh

to run the script every one hour
0 * * * * /home/ec2-user/memory_alert.sh


=========Boolean Operrators===========

AND/ && OR -a
true true true
true false false
false true false
false false false
OR ||, -o
true true true
true false true
false true true
false false false


$? == tell us whether the previously executed code is right or wrong
if $? == 0 then the previous command is right it executed
anything other than 0 means the command failed.


$# → “How many candies?” (count)

$@ → “Give me each candy one by one” (loop)

$* → “Give me all candies glued together” (string)

$? → “Did my last candy game work?” (success check)

--no-pager ==> to stop unnecessary logs 

To export any path
echo 'export PATH=$PATH:/usr/games' >> ~/.bashrc
source ~/.bashrc

set -x #to debug in shell script


========================================================================================================================

Day - 6
Output Redirection
stdin
eg:
root@ip-172-31-12-16:~/DevSecOps-Bash# ls -la
total 280
drwxr-xr-x  3 root root   4096 Dec 23 15:54 .
drwx------ 12 root root   4096 Dec 23 15:54 ..
drwxr-xr-x  8 root root   4096 Dec 23 16:02 .git
-rw-r--r--  1 root root   9074 Dec 19 11:18 3Tier.drawio
-rw-r--r--  1 root root      0 Dec 23 07:30 80%
-rw-r--r--  1 root root   4614 Dec 23 07:05 README.md
-rw-r--r--  1 root root   2112 Dec 23 15:27 README2.md
-rw-r--r--  1 root root    707 Dec 23 06:06 TOPICS_Covered
-rw-r--r--  1 root root      0 Dec 23 11:04 find
-rw-r--r--  1 root root   1299 Dec 23 11:11 find_memory_utilization.sh
-rw-r--r--  1 root root     68 Dec 19 11:17 hello.sh
-rw-r--r--  1 root root     13 Dec 23 11:04 if_condition.sh
-rw-r--r--  1 root root 196766 Dec 19 11:18 image.png
-rw-r--r--  1 root root    620 Dec 23 07:32 new_utilization.sh
-rw-r--r--  1 root root    214 Dec 23 11:57 nginx_status.sh
-rw-r--r--  1 root root    193 Dec 19 09:55 pokemon.sh
-rw-r--r--  1 root root    198 Dec 19 12:02 prove.sh
-rw-r--r--  1 root root    269 Dec 23 15:54 restart_service.sh
-rwxrwxrwx  1 root root    127 Dec 19 09:27 scripsh.sh
-rw-r--r--  1 root root     42 Dec 19 09:32 secondscript.sh
-rw-r--r--  1 root root     91 Dec 23 15:27 vpc.sh
root@ip-172-31-12-16:~/DevSecOps-Bash#


stdout
eg:
root@ip-172-31-12-16:~/DevSecOps-Bash# echo "Vihari"
Vihari

stderr
Eg:
root@ip-172-31-12-16:~/DevSecOps-Bash# megastarr
megastarr: command not found
root@ip-172-31-12-16:~/DevSecOps-Bash#

>, >>, tee, /dev/null
> == data will be overriden
>> == data will be appended
