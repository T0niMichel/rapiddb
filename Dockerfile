FROM debian:jessie
MAINTAINER TM@KUNGF.OOO
# explicitly set user/group IDs
#RUN groupadd -r postgres --gid=999 && useradd -r -g postgres --uid=999 postgres

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
    postgresql-contrib-9.4 \
    postgresql-server-dev-9.4 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG c.utf8
ENV LC_ALL c.utf8
ENV LANGUAGE en_US.utf8


#config
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.4/main/pg_hba.conf &&\
    echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf &&\
    /etc/init.d/postgresql start &&\
    mkdir -p /var/run/postgresql &&\
    chown -R postgres /var/run/postgresql

#switch user
USER postgres

RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER rapiddb WITH SUPERUSER PASSWORD 'rapiddb';" &&\
    createdb -O rapiddb develop &&\
    psql --command "GRANT ALL PRIVILEGES ON DATABASE develop TO rapiddb;" &&\
    createdb -O rapiddb production &&\
    psql --command "GRANT ALL PRIVILEGES ON DATABASE production TO rapiddb;" &&\
    createdb -O rapiddb testing &&\
    psql --command "GRANT ALL PRIVILEGES ON DATABASE testing TO rapiddb;"

VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

EXPOSE 5432
CMD ["/usr/lib/postgresql/9.4/bin/postgres", "-D", "/var/lib/postgresql/9.4/main", "-c", "config_file=/etc/postgresql/9.4/main/postgresql.conf"]