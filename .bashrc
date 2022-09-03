#!/bin/bash

if [ -t 1 ]; then
	export PS1="\e[1;34m[\e[1;33m\u@\e[1;32mDK-\h\e[1;37m:\w\[\e[1;34m]\e[1;36m\\$ \e[0m"
fi


# Aliases
alias l='ls -lAsh --color'
alias ls='ls -C1 --color'
alias cp='cp -ip'
alias rm='rm -i'
alias mv='mv -i'

alias h='cd ~;clear;'
alias speed='time curl -o /dev/null http://cachefly.cachefly.net/100mb.test'
alias speedcn='time curl -o /dev/null http://dldir1.qq.com/qqfile/qq/QQ9.0.8/24201/QQ9.0.8.24201.exe'
. /etc/os-release

echo -e -n '\E[1;34m'
figlet -k -f big -c -m-1 -w 120 "Welcome `hostname`"
echo " # ------------------------------------------------------------------------------------------------ #"

DOCKER=`ifconfig | grep -ci "docker0"`
if [ $DOCKER -eq 1 ]; then
DOCKERIP=`/sbin/ifconfig docker0 | grep 'inet' | awk '{ print $2}' | awk -F ":" '{print $2 }' | head -n 1`
alias lh="ssh root@$DOCKERIP -p "
echo " # 使用<lh SSH端口> 快速登陆宿主机 查看别名使用输入alias"
echo " # 使用<iptraf-ng> 或者<iftop> 实时查看流量统计"
fi
echo " # 使用<mtr> 路由跟踪网络,使用<iperf3> 测试网络带宽"
echo " # 使用<dig> 测试域名,使用<speed | speedcn> 测试下载带宽"

echo " # ------------------------------------------------------------------------------------------------ #"
echo -e -n '\E[1;34m'
echo -e '\E[0m'
