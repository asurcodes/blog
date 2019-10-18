FROM alpine:edge

ARG GITHUB_TOKEN

RUN apk update \
    && apk add git openssh hugo --no-cache \
    && rm -vrf /var/cache/apk/*

# SSH must be added before!
# RUN git clone --recurse-submodules --remote-submodules https://github.com/asurbernardo/blog.git
