FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
    python2.7 \
    python-pip \
    python-virtualenv \
    python-dev \
    graphviz \
    git \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && pip install --upgrade pip setuptools virtualenv

RUN groupadd -r yang && useradd -rm -d /home/yang -s /bin/bash -g yang -G sudo -u 1000 -p "$(openssl passwd -1 yang)" yang

WORKDIR /home/yang/yang-explorer
ADD . .
RUN rm -fr /home/yang/yang-explorer/v
RUN chown -R yang:yang /home/yang  && ls -la /home/yang/*
WORKDIR /home/yang/yang-explorer
USER yang
RUN chmod +x *.sh
RUN bash setup.sh
ENTRYPOINT bash start.sh

EXPOSE 8088
