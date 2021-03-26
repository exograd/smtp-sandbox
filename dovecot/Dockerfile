FROM ubuntu:20.04

LABEL maintainer "Bryan Frimin <bryan@frimin.fr>"

RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        gnupg \
        curl && \
    curl https://repo.dovecot.org/DOVECOT-REPO-GPG | gpg --import && \
    gpg --export ED409DA1 > /etc/apt/trusted.gpg.d/dovecot.gpg && \
    apt-get install -y --no-install-recommends \
        dovecot-core \
        dovecot-imapd \
        dovecot-sieve \
        dovecot-lmtpd
