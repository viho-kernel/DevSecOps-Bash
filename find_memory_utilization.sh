#!/bin/bash

TOTAL_MEM=$(free -m | grep -i mem | awk -F " " ' {print $2}')
AVAILABLE_MEM=$(free -m | grep -i mem | awk -F " " ' {print $7}')
USED_MEM=$(expr $TOTAL_MEM - $AVAILABLE_MEM)
echo "Total Memory (in MB): $TOTAL_MEM"
echo "Used Memory (in MB): $USED_MEM"
echo "Available Memory (in MB): $AVAILABLE_MEM"
echo "Memory Utilization Percentage: $(( $USED_MEM * 100 / $TOTAL_MEM | bc -1))%"