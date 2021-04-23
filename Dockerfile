FROM alpine:edge
MAINTAINER Lee Haixin <noreply@testsanjin.xyz>

LABEL vendor="lihaixin.name" \
      release-date="2021-4-22" \
      version="0.0.3"
ENV TZ=Asia/Shanghai
RUN apk add --no-cache --virtual .build-deps curl iftop mtr curl net-tools iperf3 htop tmux openssh-client bash tzdata bind-tools
      
CMD ["ping","localhost"]
