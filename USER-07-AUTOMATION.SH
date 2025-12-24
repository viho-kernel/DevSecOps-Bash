#!/bin/bash

if [$# -gt 0]; then
for USERNAME in $@; do
EXISTING_USER=$(cat /etc/passwd | grep -i -w '${USERNAME}' | cut -d ':' -f 1)
if ["${USERNAME}" = "${EXISTING_USER}"]; then
echo "The user $USERNAME is Already Exists. Try A Different Username."
else
echo "Lets Create User ${USERNAME}."
done
else
echo "You have given $# Arguments. Please provider Atleast one Arg."
fi