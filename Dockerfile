FROM --platform=${TARGETPLATFORM} alpine:3.16

ARG BUILDPLATFORM
LABEL vendor="15099.net" \
      release-date="2024-6-25" \
      version="0.0.8" \
      maintainer=noreply@15099.net
ENV TZ=Asia/Shanghai
WORKDIR /root
ENV DOCKERID=toolbox
RUN apk add --no-cache --virtual .build-deps iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata bind-tools iptables figlet iptraf-ng nmap speedtest-cli qemu-img xz
ADD ./.bashrc /root/.bashrc      
# CMD ["ping","localhost"]
ENTRYPOINT ["/bin/bash"]

