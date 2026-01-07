#!/bin/bash
#declare a function
SLACK_WEB='https://hooks.slack.com/services/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'
delete_vols(){
vols=$(aws ec2 describe-volumes --region us-east-1 | jq ".Volumes[].VolumeId" | tr -d '"')
for vol in $vols
do 
   size=$(aws ec2 describe-volumes --volume-ids vol-072bb485c0d4990dc | jq ".Volumes[].Size")

   if [ $size -gt 5 ]
   then

      echo "The volume is a production volume don't delete it."
      curl -X POST -sL -H 'Content-type: application/json' --data "{\"text\":\"${vols} is a production volume not deleted. \"}" >> $SLACK_WEB

   else

      echo "The volume is not a production volume. Proceeding with termination."

      aws ec2 delete-volume --volume-id $vol
      curl -X POST -sL -H 'Content-type: application/json' --data "{\"text\":\"${vols} is delete succesfully. \"}" >> $SLACK_WEB
   fi 
done


}