#!/bin/bash
# File: install.sh
# Description: Installs configuration files from this repo.
# Maintainer: Jack Sol

if [ -x "$(command -v bash)" ]; then
    echo 'Installing brews from .brews'
    cat ./.brews | xargs brew install
fi
