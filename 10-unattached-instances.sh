#!/bin/bash
#declare a function
WEB_URL="https://hooks.slack.com/services/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"
delete_unattached_vols(){
vols=$(aws ec2 describe-volumes --region us-east-1 | jq ".Volumes[].VolumeId" | tr -d '"')
for vol in $vols
do
status=$(aws ec2 describe-volumes --volume-ids $vol | jq ".Volumes[].Attachments[].State" -r)
instance=$(aws ec2 describe-volumes --volume-ids vol-072bb485c0d4990dc | jq ".Volumes[].Attachments[].InstanceId")

if [ "$status" = 'attached' ]; 
then
    
    echo " $vol is in use by the EC2 {$instance}. Don't delete it"
    curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\" $vol is in use by the EC2 {$instance}. Don't delete it.\"}" $WEB_URL
else
    echo " $vol is not in use. Hence, proceeding with deleting it. "
    curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$vol is not in use by the EC2 so deleting it\"}" $WEB_URL
    aws ec2 delete-volume --volume-id $vol
fi

done

}

#call function here

delete_unattached_vols