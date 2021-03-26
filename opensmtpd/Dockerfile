FROM ubuntu:20.04

LABEL maintainer "Bryan Frimin <bryan@frimin.fr>"

ENV VERSION "6.8.0p2"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        autoconf \
        automake \
        bison \
        build-essential \
        libevent-dev \
        libssl-dev \
        libtool \
        libpam0g-dev \
        zlib1g-dev \
        wget \
        ca-certificates && \
    mkdir -p /var/lib/opensmtpd/empty && \
    useradd _smtpd \
        --home-dir /var/lib/opensmtpd/empty \
        --no-create-home \
        --shell /bin/false && \
    useradd _smtpq \
        --home-dir /var/lib/opensmtpd/empty \
        --no-create-home \
        --shell /bin/false && \
    mkdir -p /var/spool/smtpd \
             /var/mail \
             /etc/mail && \
    chmod 711 /var/spool/smtpd && \
    wget -q -P /tmp/ https://github.com/OpenSMTPD/OpenSMTPD/archive/refs/tags/v$VERSION.tar.gz && \
    tar -xzf /tmp/v$VERSION.tar.gz -C /tmp && \
    cd /tmp/OpenSMTPD-$VERSION && \
    ./bootstrap && \
    ./configure --with-gnu-ld \
                --sysconfdir=/etc/mail \
                --with-auth-pam && \
    make && \
    make install && \
    cp etc/aliases /etc/mail/aliases
