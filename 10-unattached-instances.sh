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

delete_unattached_vols(){
  vols=$(aws ec2 describe-volumes --region us-east-1 | jq -r ".Volumes[].VolumeId")
  for vol in $vols; do
    status=$(aws ec2 describe-volumes --volume-ids "$vol" | jq -r ".Volumes[].Attachments[].State")
    instance=$(aws ec2 describe-volumes --volume-ids "$vol" | jq -r ".Volumes[].Attachments[].InstanceId")

    if [ "$status" = "attached" ]; then
      echo "$vol is in use by EC2 $instance. Don't delete it."
      curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$vol is in use by the EC2 $instance. Don't delete it.🗃️\"}" "$SLACK_WEBHOOK_URL"
    else
      echo "$vol is not in use. Hence, proceeding with deleting it."
      curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$vol is not in use. Deleting it...🚮\"}" "$SLACK_WEBHOOK_URL"
      aws ec2 delete-volume --volume-id "$vol"
    fi
  done
}

delete_unattached_vols