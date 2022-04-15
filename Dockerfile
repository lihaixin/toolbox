FROM alpine:edge
MAINTAINER Lee Haixin <noreply@15099.net>

LABEL vendor="15099.net" \
      release-date="2021-8-22" \
      version="0.0.4"
ENV TZ=Asia/Shanghai
WORKDIR /root
RUN apk add --no-cache --virtual .build-deps iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata bind-tools iptables figlet iptraf-ng nmap speedtest-cli
ADD ./.bashrc /root/.bashrc      
CMD ["ping","localhost"]
