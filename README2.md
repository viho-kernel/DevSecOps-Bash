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
