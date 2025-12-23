#!/bin/bash
SLACK_WEB='https://hooks.slack.com/services/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'

TOTAL_MEM=$(free -m | grep -i mem | awk -F " " ' {print $2}')
AVAILABLE_MEM=$(free -m | grep -i mem | awk -F " " ' {print $7}')
USED_MEM=$(expr $TOTAL_MEM - $AVAILABLE_MEM)
echo "Total Memory (in MB): $TOTAL_MEM"
echo "Used Memory (in MB): $USED_MEM"
echo "Available Memory (in MB): $AVAILABLE_MEM"
echo "Used Memory Utilization Percentage: $(( $USED_MEM * 100 / $TOTAL_MEM ))%"
echo "Available Memory Utilization Percentage: $(( $AVAILABLE_MEM * 100 / $TOTAL_MEM ))%"

if (($AVAILABLE_MEM <= 600)); then   
    echo "Memory is critically low. Sending Slack notification..."
    curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"Alert: Memory is critically low. Only $AVAILABLE_MEM MB available out of $TOTAL_MEM MB.\"}" $SLACK_WEB
else
    echo "Memory utilization is within acceptable limits."
fi