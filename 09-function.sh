#!/bin/bash
#declare a function

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

delete_vols(){
vols=$(aws ec2 describe-volumes --region us-east-1 | jq ".Volumes[].VolumeId" | tr -d '"')
for vol in $vols
do
size=$(aws ec2 describe-volumes --volume-ids $vol | jq ".Volumes[].Size")

if [ "$size" -gt 5 ]; 
then
    
    echo " $vol is a production volume. Please don't delete it. "
    curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\" $vol is a production volume. Please don't delete it.\"}" $SLACK_WEBHOOK_URL
else
    echo " $vol is not a proudction volume. Hence, proceeding with deleting it. "
    curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $SLACK_WEBHOOK_URL
    aws ec2 delete-volume --volume-id $vol
fi

done

}

#call function here

delete_vols


