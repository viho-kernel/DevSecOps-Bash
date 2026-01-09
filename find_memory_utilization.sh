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

ipofme=$(hostname -I | awk '{print $1}')

TOTAL_MEM=$(free -m | grep -i mem | awk -F " " ' {print $2}')
AVAILABLE_MEM=$(free -m | grep -i mem | awk -F " " ' {print $7}')
USED_MEM=$(expr $TOTAL_MEM - $AVAILABLE_MEM)
echo "Total Memory (in MB): $TOTAL_MEM"
echo "Used Memory (in MB): $USED_MEM"
echo "Available Memory (in MB): $AVAILABLE_MEM"
USED_PERCENTAGE=$(( $USED_MEM * 100 / $TOTAL_MEM ))
AVAILABLE_PERCENTAGE=$(( $AVAILABLE_MEM * 100 / $TOTAL_MEM ))
echo "Used Memory Utilization Percentage: $USED_PERCENTAGE%"
echo "Available Memory Utilization Percentage: $AVAILABLE_PERCENTAGE%"

if (($AVAILABLE_PERCENTAGE <= 60)); then   
    echo "Memory utilization of $ipofme is critically low. Sending Slack notification..."
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"Alert: Memory is critically low for $ipofme. Only $AVAILABLE_MEM MB available out of $TOTAL_MEM MB on $ipofme.\"}" $SLACK_WEBHOOK_URL
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"Alert: Memory Utilization is at $USED_PERCENTAGE%. Please take necessary actions.\"}" $SLACK_WEBHOOK_URL
    echo "Slack notification sent."
else
    echo "Memory utilization is within acceptable limits."
fi