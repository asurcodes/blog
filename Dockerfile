FROM alpine:edge

RUN apk update \
    && apk add hugo --no-cache \
    && rm -vrf /var/cache/apk/*
