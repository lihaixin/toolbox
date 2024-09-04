FROM --platform=${TARGETPLATFORM} portainer/portainer-ce:2.19.5-alpine AS buildportainer
FROM --platform=${TARGETPLATFORM} elswork/ctop AS buildctop
FROM --platform=${TARGETPLATFORM} alpine:3.16

ARG BUILDPLATFORM
LABEL vendor="15099.net" \
      release-date="2024-9-4" \
      version="0.1.0" \
      maintainer=noreply@15099.net
ENV TZ=Asia/Shanghai
WORKDIR /root
ENV DOCKERID=toolbox
COPY --from=buildportainer /docker /usr/bin/docker
COPY --from=buildctop /ctop /usr/bin/ctop
RUN apk add --no-cache --virtual .build-deps iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata bind-tools iptables figlet iptraf-ng nmap speedtest-cli qemu-img xz
ADD ./.bashrc /root/.bashrc      
# CMD ["ping","localhost"]
ENTRYPOINT ["/bin/bash"]

