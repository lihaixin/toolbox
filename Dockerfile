#
# Alpine linux docker image with OpenSSH client
#
# A minimal base image based on Alpine Linux with OpenSSH client
#

FROM alpine:3.7
LABEL vendor="lihaixin.name" \
      release-date="2018-01-2" \
      version="0.0.1"

# Set environment variables.
ENV TERM=xterm-color

# Install packages.
RUN apk --update add bash openssh-client iproute2 curl drill mtr iftop && \
    rm -rf /var/cache/apk/*

# Set the default command.
WORKDIR /bin
USER root
CMD ["ping","localhost"]
