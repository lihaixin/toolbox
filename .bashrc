#!/bin/bash

if [ -t 1 ]; then
	export PS1="\e[1;34m[\e[1;33m\u@\e[1;32mDK-\h\e[1;37m:\w\[\e[1;34m]\e[1;36m\\$ \e[0m"
fi
mtr-as() {
    if [ $# -eq 0 ]; then
        echo "用法: mtr-as <域名或IP>"
        return 1
    fi

    local target="$1"
    echo "正在追踪 $target 并查询 ASN 信息..."

    # 使用 mtr -r -n -c 10，提取 IP 和 avg（第2列和第5列）
    mtr -r -n -c 10 "$target" | awk '
        NR > 1 {
            ip = $2
            avg = $5
            # 仅处理格式为 IPv4 且 avg 为数字的行
            if (ip ~ /^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$/ && avg ~ /^[0-9.]+$/) {
                split(ip, a, ".")
                valid = 1
                for (i in a) {
                    if (a[i] < 0 || a[i] > 255) {
                        valid = 0
                        break
                    }
                }
                if (!valid) next

                # 过滤 IPv4 bogon 范围（依据 ipinfo.io 官方列表）
                if (ip ~ /^0\./ ||
                    ip ~ /^10\./ ||
                    ip ~ /^100\.([6-9][0-9]|1[01][0-9]|12[0-7])\./ ||
                    ip ~ /^127\./ ||
                    ip ~ /^169\.254\./ ||
                    ip ~ /^172\.(1[6-9]|2[0-9]|3[01])\./ ||
                    ip ~ /^192\.0\.0\./ ||
                    ip ~ /^192\.0\.2\./ ||
                    ip ~ /^192\.168\./ ||
                    ip ~ /^198\.(18|19)\./ ||
                    ip ~ /^198\.51\.100\./ ||
                    ip ~ /^203\.0\.113\./ ||
                    ip ~ /^224\./ ||
                    ip ~ /^24[0-9]\./ ||
                    ip ~ /^25[0-5]\./ ||
                    ip == "255.255.255.255") {
                    next
                }
                print ip, avg
            }
        }' | sort -u -k1,1 | while read -r ip avg; do
            if [ -n "$ip" ] && [ -n "$avg" ]; then
                org=$(curl -s "https://ipinfo.io/$ip/org" 2>/dev/null)
                if [ -z "$org" ] || [ "$org" = "null" ] || echo "$org" | grep -qE '[{[]'; then
                    org="N/A"
                fi
                printf "%-18s (%s ms) %s\n" "$ip" "$avg" "$org"
            fi
        done
}

# Aliases
alias l='ls -lAsh --color'
alias ls='ls -C1 --color'
alias cp='cp -ip'
alias rm='rm -i'
alias mv='mv -i'
alias tmux='tmux -u'
alias h='cd ~;clear;'
alias speed='time curl -o /dev/null http://cachefly.cachefly.net/100mb.test'
alias speedcn='time curl -o /dev/null http://dldir1.qq.com/qqfile/qq/QQ9.0.8/24201/QQ9.0.8.24201.exe'
alias sshx='curl -sSf https://sshx.io/get | sh -s run'
alias reboot='kill -9 `pgrep bash` 1> /dev/null 2>&1;sleep 1;pkill -s 1'
. /etc/os-release

echo -e -n '\E[1;34m'
figlet -k -f big -c -m-1 -w 120 "Welcome `hostname`"
echo " # ------------------------------------------------------------------------------------------------ #"

DOCKER=`ifconfig | grep -ci "docker0"`
if [ $DOCKER -eq 1 ]; then
DOCKERIP=`/sbin/ifconfig docker0 | awk '/inet / {gsub("addr:", "", $2); print $2}'`
alias lh="ssh root@$DOCKERIP -p "
echo " # 使用<lh SSH端口> 快速登陆宿主机 查看别名使用输入alias"
echo " # 使用<iptraf-ng> 或者<iftop> 实时查看流量统计"
fi
echo " # 使用<mtr> 路由跟踪网络,使用<iperf3> 测试网络带宽"
echo " # 使用<dig> 测试域名,使用<speed | speedcn> 测试下载带宽"

echo " # ------------------------------------------------------------------------------------------------ #"

echo -e -n '\E[1;34m'
echo -e '\E[0m'
