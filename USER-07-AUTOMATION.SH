#!/bin/bash

if [$# -gt 0]; then
for USERNAME in $@; do
EXISTING_USER=$(cat /etc/passwd | grep -i -w '${USERNAME}' | cut -d ':' -f 1)

done
else
echo "You have given $# Arguments. Please provider Atleast one Arg."
fi