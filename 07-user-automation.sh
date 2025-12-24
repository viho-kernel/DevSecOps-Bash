#check how many parameters are passed if no parameters exit the script
#check if user is already existed and create if not exists.
#make sure user has sudo permissions.
#Expire the password forcing to reset it.

#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'
#USERNAME=$1
if [$# -gt 0]; then
for USERNAME in $@; do
#CHECK EXISTING USER
EXISTING_USER=$(cat /etc/passwd | grep -i -w ${USERNAME} | cut -d ':' -f 1)
if [ "${USERNAME}" = "${EXISTING_USER}" ]; then
echo "The User ${USERNAME} Already Exists. Try a difference Username."
else 
echo "Lets Create user ${USERNAME}."
sudo useradd -m $USERNAME --shell /bin/bash -d /home/${USERNAME}
sudo usermod -aG sudo ${USERNAME}
echo '${USERNAME} ALL=(ALL) NOPASSWD: ALL' >>/etc/sudoers
SPEC=$(echo '!@#$%^&*()_' | fold -w1 | shuf | head -1)
PASSWORD="India@{RANDOM}${SPEC}"
echo "${USERNAME}:${PASSWORD}" | sudo chpasswd
passwd -e ${USERNAME}
echo "The Temporary Credentails are ${USERNAME} and ${PASSWORD}"
curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Username is: ${USERNAME}\"}" >>/dev/null
    curl -X POST ${SLACK_WEB} -sL -H 'Content-type: application/json' --data "{"text": \"Temporary Password Is: ${PASSWORD}  Reset This Password Immediatly.\"}" >>/dev/null
fi
done
else
echo "You have given $# Arguments. Please provide atleast one Arg."
fi