#!/usr/bin/env bash
#: report with date and system components(cpu model, total mem, disk space)

G='\033[0;32m'
C='\033[0m'

printf "${G}Log Date:${C} $(date)\n\n"
printf "${G}Home directory ($HOME):${C}\n"
ls -a $HOME && echo
printf "${G}CPU and MEM information:${C}\n"
cat /proc/cpuinfo | grep "model name" | head -n 1
cat /proc/cpuinfo | grep "cpu cores" | head -n 1
cat /proc/cpuinfo | grep "cpu MHz" | head -n 1
cat /proc/meminfo | grep "MemTotal"
cat /proc/meminfo | grep "SwapTotal" && echo
printf "${G}Disk partition information:${C}\n"
df -h --output=source,fstype,size,used,avail,pcent,target -x tmpfs -x devtmpfs

#END
