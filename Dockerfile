# syntax=docker/dockerfile:1.0-experimental
FROM alpine:3.9.4

ARG BUILD_DATE
ARG VCS_REF


LABEL maintainer="mateumann@gmail.com" \
    org.label-schema.name="privoxy" \
    org.label-schema.description="Image for running a single Privoxy instance" \
    org.label-schema.usage="/LICENSE" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.vcs-url="https://github.com/mateumann/docker-privoxy.git" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.version="0.1.0" \
    org.label-schema.schema-version="1.0" \
    com.microscaling.license="MIT" 

ARG PRIVOXY_INSTANCE
ENV PRIVOXY_INSTANCE=$PRIVOXY_INSTANCE

COPY config.template /etc/privoxy/config.template
COPY entrypoint.sh /

RUN apk update && \
    apk add --no-cache privoxy && \
    chown privoxy:nogroup /etc/privoxy/config.template

USER privoxy

EXPOSE 8118

ENTRYPOINT ["/entrypoint.sh"]
