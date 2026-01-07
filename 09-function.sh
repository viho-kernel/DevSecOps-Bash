#!/bin/bash
#declare a function
WEB_URL="https://hooks.slack.com/services/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"
delete_vols(){
vols=$(aws ec2 describe-volumes --region us-east-1 | jq ".Volumes[].VolumeId" | tr -d '"')
for vol in $vols
do 
   size=$(aws ec2 describe-volumes --volume-ids vol-072bb485c0d4990dc | jq ".Volumes[].Size")

   if [ $size -gt 5 ]
   then

      echo "The volume is a production volume don't delete it."
      curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"${vols} is a proudction environment will not delete it.\"}" $WEB_URL

   else

      echo "The volume is not a production volume. Proceeding with termination."

      aws ec2 delete-volume --volume-id $vol
      curl -s -X POST -H 'Content-type: application/json' \
    --data "{\"text\":\"${vols} has been terminated\"}" $WEB_URL
   fi 
done


}