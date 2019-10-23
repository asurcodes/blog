FROM alpine:edge

RUN apk update \
    && apk add git hugo --no-cache \
    && rm -vrf /var/cache/apk/*

RUN git clone https://github.com/asurbernardo/blog.git

WORKDIR /blog

RUN git submodule foreach pull origin master

EXPOSE 1313