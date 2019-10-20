FROM alpine:edge

RUN apk update \
    && apk add git openssh hugo --no-cache \
    && rm -vrf /var/cache/apk/*

RUN git config --global url."https://$GITHUB_TOKEN:@github.com/".insteadOf "https://github.com/"
RUN git config --global url."https://$GITHUB_TOKEN:@github.com/".insteadOf "git@github.com:"

RUN git clone --recurse-submodules --remote-submodules https://github.com/asurbernardo/blog.git

WORKDIR /blog 

RUN rm -rf .git*

EXPOSE 1313

CMD ["hugo","-t","amperage","server","--buildFuture","--bind","0.0.0.0"]
