#!/bin/bash

awk '{u=$2+$4; t=$2+$4+$5; if (NR==1){u1=u; t1=t;} else print ($2+$4-u1) * 100 / (t-t1) "% CPU usage"; }' \
<(grep 'cpu ' /proc/stat) <(sleep 1;grep 'cpu ' /proc/stat)

df -h / | grep '/' | awk '{print $5 " Disk usage"}'


read total used free <<< $(free -m | awk '/^Mem:/ {print $2, $3, $4}')

usage_percent=$((100 * used / total))

echo "${usage_percent}% Memory usage"

echo "============ Top 5 CPU Usage =================="

ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo "============ Top 5 Memory Usage =================="

ps -eo pid,comm,%mem,%cpu --sort=-%mem | head -n 6
