FROM alpine:3.10

ARG VW_VERSION=8.8.0
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apk add --no-cache --virtual build-deps cmake curl libtool m4 autoconf git g++ make zlib-dev clang-dev openjdk8 && \
    apk add --no-cache dumb-init boost-dev && \
    export JAVA_HOME=/usr/lib/jvm/default-jvm && \
    mkdir /app && \
    cd /app && \
    git clone https://github.com/VowpalWabbit/vowpal_wabbit.git && \
    cd vowpal_wabbit && \
    git checkout $VW_VERSION && \
    make CXX='clang++' install && \
    cd / && \
    rm -rf /app && \
    apk del build-deps && \
    rm -rf /var/cache/apk/* && \
    mkdir /data

EXPOSE 26542
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/vw"]
CMD ["--help"]
