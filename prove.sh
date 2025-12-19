
#!/bin/bash

REGIONS=$@

for REGION in $REGIONS
do
    cowsay "Region: $REGION"
    aws ec2 describe-vpcs --region "$REGION" \
    | jq -r '.Vpcs[].VpcId'
    echo "---------------------"
done




