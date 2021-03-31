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
        dovecot-pop3d \
        dovecot-sieve \
        dovecot-managesieved \
        dovecot-lmtpd \
        dovecot-pgsql && \
    apt-get remove \
        --purge \
        --yes \
        --allow-remove-essential \
        gnupg curl && \
    apt-get autoremove --yes && \
    apt-get clean --yes

EXPOSE 143
EXPOSE 110

CMD ["dovecot", "-F"]
