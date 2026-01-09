#!/bin/bash
#WEB_URL="https://hooks.slack.com/services/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"

delete_unattached_vols(){
  vols=$(aws ec2 describe-volumes --region us-east-1 | jq -r ".Volumes[].VolumeId")
  for vol in $vols; do
    status=$(aws ec2 describe-volumes --volume-ids "$vol" | jq -r ".Volumes[].Attachments[].State")
    instance=$(aws ec2 describe-volumes --volume-ids "$vol" | jq -r ".Volumes[].Attachments[].InstanceId")

    if [ "$status" = "attached" ]; then
      echo "$vol is in use by EC2 $instance. Don't delete it."
      curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$vol is in use by the EC2 $instance. Don't delete it.🗃️\"}" "$WEB_URL"
    else
      echo "$vol is not in use. Hence, proceeding with deleting it."
      curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$vol is not in use. Deleting it...🚮\"}" "$WEB_URL"
      aws ec2 delete-volume --volume-id "$vol"
    fi
  done
}

delete_unattached_vols