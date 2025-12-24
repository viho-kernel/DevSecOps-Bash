#!/bin/bash

SERVERS=('10.1.1.100' '10.1.1.101' '10.39.1.186' '10.139.1.100' '172.31.12.16')
echo ${SERVERS[@]}
for SERVER in ${SERVERS[@]};
do
  echo "Testing connectivity to: $SERVER"
  netcat -z -v -n $SERVER 21-23 2>&1 | grep succeeded
done