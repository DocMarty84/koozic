FROM ubuntu:xenial
MAINTAINER DocMarty84 <nicolas.martinelli@gmail.com>

# Set up user and mount point
RUN set -x; \
        useradd -m koozic && \
        mkdir -p /mnt/host && \
        chown -R koozic /mnt/host

# Reconfigure locales so PostgreSQL uses UTF-8 encoding
RUN set -x; \
        apt-get update -qq && \
        apt-get install -y --no-install-recommends -qq locales && \
        apt-get clean -qq && \
        dpkg-reconfigure locales && \
        locale-gen en_US.UTF-8 && \
        /usr/sbin/update-locale LANG=en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Install mandatory dependencies
RUN set -x; \
        apt-get install -y --no-install-recommends -qq \
            adduser \
            node-less \
            postgresql-client \
            python python-dateutil \
            python-decorator \
            python-docutils \
            python-feedparser \
            python-imaging \
            python-jinja2 \
            python-ldap \
            python-libxslt1 \
            python-lxml \
            python-mako \
            python-mock \
            python-openid \
            python-passlib \
            python-psutil \
            python-psycopg2 \
            python-pybabel \
            python-pychart \
            python-pydot \
            python-pyparsing \
            python-pypdf \
            python-reportlab \
            python-requests \
            python-suds \
            python-tz \
            python-vatnumber \
            python-vobject \
            python-werkzeug \
            python-xlsxwriter \
            python-xlwt \
            python-yaml \
            postgresql \
            python-mutagen \
            mediainfo && \
        apt-get clean -qq

# Install optional dependencies
RUN set -x; \
        apt-get install -y --no-install-recommends -qq \
            python-psycogreen \
            python-gevent \
            python-dev \
            python-pip \
            python-setuptools \
            python-wheel \
            libtag1-dev \
            build-essential \
            wget && \
        pip install pytaglib==1.4.1 && \
        apt-get clean -qq

# Install FFmpeg
RUN set -x; \
        wget -q https://github.com/DocMarty84/koozic/raw/master/extra/ffmpeg/ffmpeg-3.4-64bit.tar.gz && \
        tar xfz ffmpeg-*-64bit.tar.gz && \
        mv ffmpeg /usr/local/bin && \
        rm -rf ffmpeg-*

# Install KooZic
RUN set -x; \
        wget -q https://github.com/DocMarty84/koozic/releases/download/v0.8.0/koozic-v0.8.0.tar.gz && \
        tar xfz koozic-v0.8.0.tar.gz && \
        mv koozic /usr/local/ && \
        chown -R koozic /usr/local/koozic && \
        rm -rf koozic-v0.8.0.tar.gz

# Set up PostgreSQL and KooZic
RUN set -x; \
        sed -i 's/5432/54321/g' /etc/postgresql/9.5/main/postgresql.conf && \
        service postgresql start && \
        sleep 5 && \
        su - postgres -c "createuser -s koozic" && \
        su - koozic -c "/usr/local/koozic/odoo-bin -d koozic --db_port=54321 -i oomusic,oovideo --stop-after-init --log-level=warn"

# Copy entrypoint script
COPY ./entrypoint.sh /

# Expose KooZic services
EXPOSE 8069 8072

ENTRYPOINT ["/entrypoint.sh"]
