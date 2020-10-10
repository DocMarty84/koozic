FROM ubuntu:18.04
MAINTAINER DocMarty84 <nicolas.martinelli@pm.me>

# Reconfigure locales to use UTF-8 encoding
RUN set -x; \
        apt-get update -qq && \
        apt-get install -y --no-install-recommends -qq locales

RUN set -x; \
        dpkg-reconfigure -fnoninteractive locales && \
        sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen && \
        locale-gen en_US.UTF-8 && \
        /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install apt dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN set -x; \
        apt-get update -qq && \
        apt-get install -y --no-install-recommends -qq \
            adduser \
            build-essential \
            ffmpeg \
            libtag1-dev \
            lsb-base \
            mediainfo \
            postgresql-common \
            python3-babel \
            python3-chardet \
            python3-dateutil \
            python3-decorator \
            python3-dev \
            python3-docutils \
            python3-feedparser \
            python3-gevent \
            python3-html2text \
            python3-jinja2 \
            python3-libsass \
            python3-lxml \
            python3-mako \
            python3-mock \
            python3-passlib \
            python3-pil \
            python3-pip \
            python3-polib \
            python3-psutil \
            python3-psycopg2 \
            python3-pydot \
            python3-pyldap \
            python3-pyparsing \
            python3-pypdf2 \
            python3-qrcode \
            python3-reportlab \
            python3-requests \
            python3-setuptools \
            python3-tz \
            python3-vatnumber \
            python3-vobject \
            python3-werkzeug \
            python3-wheel \
            python3-xlsxwriter \
            python3-yaml \
            python3-zeep \
            wget && \
        apt-get clean -qq

# Install pip dependencies
RUN set -x; \
        pip3 install \
            mutagen==1.43.0 \
            pytaglib==1.4.5 \
            num2words==0.5.6 \
            webvtt-py==0.4.2

# PostgreSQL install: deactivate automatic cluster creation since it will created at runtime in a
# mounted location. Copied from https://github.com/docker-library/postgres/tree/master/10
RUN set -x; \
        sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf && \
        apt-get install -y --no-install-recommends -qq \
            postgresql \
            postgresql-client

# Set up user and mount point
RUN set -x; \
        useradd -m koozic && \
        mkdir -p /mnt/host && \
        chown -R koozic /mnt/host

# Install KooZic
RUN set -x; \
        v=v3.1.0 && \
        wget -q https://github.com/DocMarty84/koozic/releases/download/${v}/koozic-${v}.tar.gz && \
        tar xfz koozic-*.tar.gz && \
        rm -rf koozic-*.tar.gz
RUN set -x; \
        mv koozic /usr/local/ && \
        chown -R koozic /usr/local/koozic

# Copy entrypoint script
COPY ./entrypoint.sh /

# Expose KooZic services
EXPOSE 8069 8072

ENTRYPOINT ["/entrypoint.sh"]
