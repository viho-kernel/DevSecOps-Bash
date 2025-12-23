#!/bin/bash
FREE_MEM=$(df -h | grep -i '/dev/root' | awk -F " " '{print $4}')
USED_MEM=$(df -h | grep -i '/dev/root' | awk -F " " '{print $3}')
TOTAL_MEM=$(df -h | grep -i '/dev/root' | awk -F " " '{print $2}')
DISK_MEM_UTIL=$(df -h | grep -i '/dev/root' | awk -F " " '{print $5}' | tr -d '%')
echo "Total Disk Memory: $TOTAL_MEM"
echo "Used Disk Memory: $USED_MEM"
echo "Free Disk Memory: $FREE_MEM"
echo "Disk Memory Utilization Percentage: $DISK_MEM_UTIL"

if [ $DISK_MEM_UTIL -gt 80 ]; then
  echo "Warning: Disk memory utilization is above 80%."
else
  echo "Disk memory utilization is within acceptable limits."
fi