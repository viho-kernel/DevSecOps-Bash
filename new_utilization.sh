#!/bin/bash
FREE_MEM=$(df -h | grep -i '/dev/root' | awk -F " " '{print $4}')
USED_MEM=$(df -h | grep -i '/dev/root' | awk -F " " '{print $3}')
TOTAL_MEM=$(df -h | grep -i '/dev/root' | awk -F " " '{print $2}')
echo "Total Disk Memory: $TOTAL_MEM"
echo "Used Disk Memory: $USED_MEM"
echo "Free Disk Memory: $FREE_MEM"
echo "Disk Memory Utilization Percentage: $(df -h | grep -i '/dev/root' | awk -F " " '{print $5}')"