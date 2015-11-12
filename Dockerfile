FROM debian:jessie
MAINTAINER TM@KUNGF.OOO
RUN apt-get update && apt-get install -y locales \
    tar \
    git \
    curl \
    nano \
    sudo \
    wget \
    net-tools \
    build-essential \
    postgresql-9.4 \
    postgresql-client-9.4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG c.utf8
ENV LC_ALL c.utf8
ENV LANGUAGE en_US.utf8
