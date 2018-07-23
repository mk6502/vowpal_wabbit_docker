FROM alpine:3.8

ARG VW_VERSION=8.6.1
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apk add --no-cache --virtual build-deps curl libtool m4 autoconf g++ make zlib-dev clang-dev openjdk8 && \
    apk add --no-cache dumb-init boost-dev && \
    export JAVA_HOME=/usr/lib/jvm/default-jvm && \
    mkdir /app && \
    cd /app && \
    curl https://codeload.github.com/JohnLangford/vowpal_wabbit/tar.gz/$VW_VERSION -o vw.tar.gz && \
    tar xzf vw.tar.gz && \
    cd vowpal_wabbit-$VW_VERSION && \
    make CXX='clang++' install && \
    cd / && \
    rm -rf /app && \
    apk del build-deps && \
    rm -rf /var/cache/apk/* && \
    mkdir /data

EXPOSE 26542
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/vw"]
CMD ["--help"]
