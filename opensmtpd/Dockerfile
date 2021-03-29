# Copyright (c) 2021 Bryan Frimin <bryan@frimin.fr>.
#
# Permission to use, copy, modify, and/or distribute this software for
# any purpose with or without fee is hereby granted, provided that the
# above copyright notice and this permission notice appear in all
# copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL
# WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE
# AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
# DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
# PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
# TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

FROM ubuntu:20.04

LABEL maintainer "Bryan Frimin <bryan@frimin.fr>"

ENV VERSION "6.8.0p2"

RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
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
    mkdir --parents /var/empty && \
    useradd _smtpd \
        --home-dir /var/lib/opensmtpd/empty \
        --no-create-home \
        --shell /bin/false && \
    useradd _smtpq \
        --home-dir /var/lib/opensmtpd/empty \
        --no-create-home \
        --shell /bin/false && \
    mkdir --parents \
        /var/spool/smtpd \
        /var/mail \
        /etc/mail && \
    chmod 711 /var/spool/smtpd && \
    wget \
        --quiet \
        --directory-prefix /tmp/ \
        https://github.com/OpenSMTPD/OpenSMTPD/archive/refs/tags/v$VERSION.tar.gz && \
    tar \
        --extract \
        --ungzip \
        --directory /tmp \
        --file /tmp/v$VERSION.tar.gz && \
    cd /tmp/OpenSMTPD-$VERSION && \
    ./bootstrap && \
    ./configure \
        --prefix=/usr \
        --sbindir=/usr/bin \
        --sysconfdir=/usr/etc/mail \
        --libexecdir=/usr/lib/smtpd \
        --with-path-mbox=/var/spool/mail \
        --with-path-empty=/var/empty \
        --with-path-socket=/run \
        --with-user-smtpd=_smtpd \
        --with-user-queue=_smtpq \
        --with-group-queue=_smtpq \
        --with-gnu-ld \
        --with-auth-pam && \
    make && \
    make install && \
    cp etc/aliases /etc/mail/aliases && \
    rm \
        --recursive \
        --force \
        /tmp/v$VERSION.tar.gz /tmp/OpenSMTPD-$VERSION && \
    apt-get remove \
        --purge \
        --yes \
        --allow-remove-essential \
        wget autoconf automake && \
    apt-get autoremove --yes && \
    apt-get clean --yes

COPY smtpd.conf /usr/etc/mail/smtpd.conf

CMD ["smtpd", "-dv"]
