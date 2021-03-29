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

ENV VERSION "1.4.11"

# Roundcube
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
        ca-certificates \
        gnupg2 \
        php7.0-fpm php7.0 php7.0-xml php7.0-mbstring php7.0-intl 

        wget && \
    wget \
        --quiet \
        --directory-prefix /tmp \
        https://github.com/roundcube/roundcubemail/releases/download/$VERSION/roundcubemail-$VERSION-complete.tar.gz && \
    tar \
        --extract \
        --ungzip \
        --directory /tmp \
        --file /tmp/roundcubemail-$VERSION-complete.tar.gz && \
    mkdir --parents /var/www/roundcube && \
    cp --recursive /tmp/roundcubemail-$VERSION /var/www/roundcube

# NGINX
RUN echo "deb http://nginx.org/packages/ubuntu focal nginx" \
        | tee /etc/apt/sources.list.d/nginx.list && \
    wget \
        --quiet \
        --directory-prefix /tmp \
        https://nginx.org/keys/nginx_signing.key && \
    mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc && \
    apt-get update --yes && \
    apt-get install nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
