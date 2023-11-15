FROM --platform=${TARGETPLATFORM} lihaixin/base:3.16
MAINTAINER Lee Haixin <noreply@15099.net>

LABEL vendor="15099.net" \
      release-date="2023-11-15" \
      version="0.0.7"
ENV TZ=Asia/Shanghai
WORKDIR /root
ENV DOCKERID=toolbox
RUN apk add --no-cache --virtual .build-deps iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata bind-tools iptables figlet iptraf-ng nmap speedtest-cli qemu-img
ADD ./.bashrc /root/.bashrc      
# CMD ["ping","localhost"]
ENTRYPOINT ["/bin/bash"]

