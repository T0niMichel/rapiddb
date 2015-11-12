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
    postgresql-server-dev-9.4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG c.utf8
ENV LC_ALL c.utf8
ENV LANGUAGE en_US.utf8


RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER rapiddb WITH SUPERUSER PASSWORD 'rapiddb';" &&\
    createdb -O rapiddb rapiddb

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf

EXPOSE 5432

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]
CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D", "/var/lib/postgresql/9.4/main", "-c", "config_file=/etc/postgresql/9.4/main/postgresql.conf"]