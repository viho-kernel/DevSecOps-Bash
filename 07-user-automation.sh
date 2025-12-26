#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
USERNAME=$1
if [ $# -gt 0 ]; then
EXISTING_USER=$(cat /etc/passwd | grep -i -w ${USERNAME} | cut -d ':' -f 1)
if [ "${USERNAME}" = "${EXISTING_USER}" ]; then
echo "The user ${USERNAME} Already Exists. Try with a different Username."
else
echo "Lets Create User ${USERNAME}."
sudo useradd -m $USERNAME --shell /bin/bash -d "/home/${USERNAME}"
sudo usermod -aG sudo ${USERNAME}
#echo '${USERNAME} ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
PASSWORD="India@${RANDOM}${SPEC}"
echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
sudo passwd -e ${USERNAME}
echo "The Temporary credentials are ${USERNAME} and ${PASSWORD}"
curl -X POST $SLACK_WEB -sL -H 'Content-type: application/json' --data "{\"text\":\"Username is: ${USERNAME}.\"}" >> /dev/null
curl -X POST $SLACK_WEB -sL -H 'Content-type: application/json' --data "{\"text\":\"Temporary password is ${PASSWORD}. Please change you're Temporary passwod immediately.\"}" 
sed "66 s/.*PasswordAuthentication.*/PasswordAuthentication yes/g" /etc/ssh/sshd_config
fi

else
echo "You've given $# arguments. Please provide atleast one Arg."
fi