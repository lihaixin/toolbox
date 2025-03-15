FROM --platform=${TARGETPLATFORM} portainer/portainer-ce:2.19.5-alpine AS buildportainer
FROM --platform=${TARGETPLATFORM} ekzhang/bore AS buildbore
FROM --platform=${TARGETPLATFORM} elswork/ctop AS buildctop
FROM --platform=${TARGETPLATFORM} alpine:3.20

ARG BUILDPLATFORM
LABEL vendor="15099.net" \
      release-date="2025-3-15" \
      version="0.2.0" \
      maintainer=noreply@15099.net
ENV TZ=Asia/Shanghai
WORKDIR /root
ENV DOCKERID=toolbox
COPY --from=buildportainer /docker /usr/bin/docker
COPY --from=buildctop /usr/bin/ctop /usr/bin/ctop
COPY --from=buildbore /bore /usr/bin/bore
RUN apk add --no-cache --virtual .build-deps iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata bind-tools iptables figlet iptraf-ng nmap speedtest-cli qemu-img xz musl lm-sensors
ADD ./.bashrc /root/.bashrc      
# CMD ["ping","localhost"]
ENTRYPOINT ["/bin/bash"]

