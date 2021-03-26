FROM ubuntu:20.04

LABEL maintainer "Bryan Frimin <bryan@frimin.fr>"

ENV VERSION "1.4.11"

# Roundcube
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        wget && \
    wget -q -P /tmp https://github.com/roundcube/roundcubemail/releases/download/$VERSION/roundcubemail-$VERSION-complete.tar.gz && \
    tar -xzf /tmp/roundcubemail-$VERSION-complete.tar.gz -C /tmp


# NGINX
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        gnupg2 \
        lsb-release && \
    echo "deb http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
        | tee /etc/apt/sources.list.d/nginx.list && \
    wget -q -P /tmp https://nginx.org/keys/nginx_signing.key && \
    mv /tmp/nginx_signing.key /etc/apt/trusted.gpg.d/nginx_signing.asc && \
    apt-get update -y && \
    apt-get install nginx

