#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
#USERNAME=$1
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
curl -X POST $SLACK_WEB -sL -H 'Content-type: application/json' --data "{\"text\":\"Username is: ${USERNAME}.\"}" >> /dev/null
curl -X POST $SLACK_WEB -sL -H 'Content-type: application/json' --data "{\"text\":\"Temporary password is ${PASSWORD}. Please change you're Temporary passwod immediately.\"}" 

fi

else
 echo "The username given is not correct. Give a username with 6 character length and it contains 3 digits and  3 letters"
fi
done
else
echo "You've given $# arguments. Please provide atleast one Arg."
fi