#!/bin/bash
#declare a function
WEB_URL="https://hooks.slack.com/services/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"
delete_vols(){
vols=$(aws ec2 describe-volumes --region us-east-1 | jq ".Volumes[].VolumeId" | tr -d '"')
for vol in $vols
do 
   size=$(aws ec2 describe-volumes --volume-ids $vol | jq ".Volumes[].Size")
   if [ $size -gt 5 ]
   then
      echo "The $vol volume is a production volume don't delete it."
      curl -X POST -sL -H 'Content-type: application/json' \
    --data "{\"text\":\"${vol} is a proudction environment will not delete it.\"}" $WEB_URL

   else

      echo "The $vol volume is not a production volume. Proceeding with termination."
      aws ec2 delete-volume --volume-id $vol
      curl -X POST -sL -H 'Content-type: application/json' \
    --data "{\"text\":\"${vol} has been terminated\"}" $WEB_URL
   fi 
done


}

#call function here

delete_vols