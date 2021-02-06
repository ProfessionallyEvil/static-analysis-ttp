#!/usr/bin/env bash

sudo apt install \
    git \
    python3 \
    openjdk-8-jdk \
    python3-venv \
    python3-pip \
    python3-dev \
    build-essential \
    libffi-dev \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    libjpeg8-dev \
    zlib1g-dev \
    wkhtmltopdf

git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
cd Mobile-Security-Framework-MobSF || exit
./setup.sh
