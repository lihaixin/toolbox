FROM alpine:edge
MAINTAINER Lee Haixin <noreply@testsanjin.xyz>

LABEL vendor="lihaixin.name" \
      release-date="2021-4-22" \
      version="0.0.2"
ENV TZ=Asia/Shanghai
RUN apk add --no-cache --virtual .build-deps curl iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata dnsutils \
    && rm -rf /var/cache/apk/*
CMD ["ping","localhost"]
