#!/usr/bin/env bash
#: report with date and system components(cpu model, total mem, disk space)

echo Log Date: $(date) && echo
echo Home directory:
echo $HOME
ls -a ~/ && echo
echo CPU and MEM information:
cat /proc/cpuinfo | grep "model name" | head -n 1
cat /proc/cpuinfo | grep "cpu cores" | head -n 1
cat /proc/cpuinfo | grep "cpu MHz" | head -n 1
cat /proc/meminfo | grep "MemTotal"
cat /proc/meminfo | grep "SwapTotal" && echo
echo Disk partition information:
df -h --output=source,fstype,size,used,avail,pcent,target -x tmpfs -x devtmpfs

#END
