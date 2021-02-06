#!/usr/bin/env bash

set -euxo pipefail

sudo apt install -y python{,3}-pip
pip install bandit
pip3 install bandit
