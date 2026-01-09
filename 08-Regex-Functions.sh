#!/bin/bash

set -euo pipefail


CONFIG_FILE="$(dirname "$0")/config.env" 
if [ -f "$CONFIG_FILE" ]; then 
# shellcheck disable=SC1090 
source "$CONFIG_FILE" 
fi 
# Fail fast if variable not set 
if [ -z "${SLACK_WEBHOOK_URL:-}" ]; then 
echo "Error: SLACK_WEBHOOK_URL not set. Please create config.env or export it in your environment." 
exit 1 
fi

if [ $# -gt 0 ]; then
for USERNAME in $@
do
if [[ '${USERNAME}' =~ ^$[a-z][a-z][a-z][0-9][0-9][0-9]$ ]]; then
EXISTING_USER=$(cat /etc/passwd | grep -i -w '$USERNAME' | cut -d ':' -f1) 

if [ '$USERNAME' = '$EXISTING_USER' ]; then
echo " The user ${USERNAME} already existed. Kindly check and provider valid username. "
else
echo "Let's create a user ${USERNAME} "
sudo useradd -m $USERNAME --shell /bin/bash -d "/home/${USERNAME}"
sudo usermod -aG sudo ${USERNAME} #giving user root credentials
echo '${USERNAME} ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers #this set no password to user
SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
PASSWORD=${"India@${RANDOM}${SPEC}"}
echo "${USERNAME}:${PASSWORD}" | sudo chpasswd #change password
sudo passwd -e ${USERNAME} #expire password
echo "The Temporary credentials are ${USERNAME} and ${PASSWORD}"
curl -X POST $SLACK_WEBHOOK_URL -sL -H 'Content-type: application/json' --data "{\"text\":\"Username is: ${USERNAME}.\"}" >> /dev/null
curl -X POST $SLACK_WEBHOOK_URL -sL -H 'Content-type: application/json' --data "{\"text\":\"Temporary password is ${PASSWORD}. Please change you're Temporary passwod immediately.\"}" 

fi

else
 echo "The username given is not correct. Give a username with 6 character length and it contains 3 digits and  3 letters"
fi
done
else
echo "You've given $# arguments. Please provide atleast one Arg."
fi