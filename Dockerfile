FROM ubuntu:18.04

ARG VW_VERSION=8.6.0
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt-get update --fix-missing && \
    DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true apt-get install -y --no-install-recommends clang curl libtool zlib1g-dev m4 autoconf automake make libboost-program-options-dev default-jdk-headless && \
    export JAVA_HOME=/usr/lib/jvm/default-java && \
    mkdir /app && \
    cd /app && \
    curl https://codeload.github.com/JohnLangford/vowpal_wabbit/tar.gz/$VW_VERSION -o vw.tar.gz && \
    tar xzf vw.tar.gz && \
    cd vowpal_wabbit-$VW_VERSION && \
    make CXX='clang++' install && \
    cd / && \
    rm -rf /app && \
    apt-get autoremove --purge -y clang curl libtool zlib1g-dev m4 autoconf automake make && \
    apt-get clean autoclean && \
    rm -rf /var/lib/apt /var/lib/dpkg /var/lib/cache /var/lib/log && \
    mkdir /data

EXPOSE 26542
ENTRYPOINT ["/usr/local/bin/vw"]
CMD ["--help"]
