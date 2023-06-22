# syntax=docker/dockerfile:1.0-experimental
FROM alpine:3.18

ARG BUILD_DATE
ARG VCS_REF

ENV PRIVOXY_INSTANCE 0

LABEL maintainer="mateumann@gmail.com" \
    org.label-schema.name="privoxy" \
    org.label-schema.description="Image for running a single Privoxy instance" \
    org.label-schema.usage="/LICENSE" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-url="https://github.com/mateumann/docker-privoxy.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version="0.7.0" \
    org.label-schema.schema-version="1.0" \
    com.microscaling.license="MIT"

RUN apk update && \
    apk add --no-cache privoxy=3.0.34-r2 && \
    rm -rf /var/cache/apk/* && \
    rm -f /etc/privoxy/config.new

USER privoxy
COPY --chown=privoxy:privoxy config.template /etc/privoxy/config.template
COPY entrypoint.sh /


EXPOSE 8118

ENTRYPOINT ["/entrypoint.sh"]
