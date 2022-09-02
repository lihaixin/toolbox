FROM --platform=${TARGETPLATFORM} alpine:edge
MAINTAINER Lee Haixin <noreply@15099.net>

LABEL vendor="15099.net" \
      release-date="2022-9-2" \
      version="0.0.5"
ENV TZ=Asia/Shanghai
WORKDIR /root
RUN apk add --no-cache --virtual .build-deps iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata bind-tools iptables figlet iptraf-ng nmap speedtest-cli
ADD ./.bashrc /root/.bashrc      
CMD ["ping", "localhost", "1>", "/dev/null", "2>&1"]

