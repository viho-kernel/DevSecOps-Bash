#!/bin/bash
#declare a function
WEB_URL="https://hooks.slack.com/services/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"
delete_vols(){
vols=$(aws ec2 describe-volumes --region us-east-1 | jq ".Volumes[].VolumeId" | tr -d '"')
for vol in $vols
do
size=$(aws ec2 describe-volumes --volume-ids $vol | jq ".Volumes[].Size")

if [ "$size" -gt 20 ]; 
then
    
    echo " $vol is a production volume. Please don't delete it. "
    curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\" $vol is a production volume. Please don't delete it.\"}" $WEB_URL
else
    echo " $vol is not a proudction volume. Hence, proceeding with deleting it. "
    curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"$MESSAGE\"}" $WEB_URL
    aws ec2 delete-volume --volume-id $vol
fi

done

}

#call function here

delete_vols