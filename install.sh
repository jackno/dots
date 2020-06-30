#!/bin/bash
# File: install.sh
# Description: Installs configuration files from this repo.
# Maintainer: Jack Sol

if [ -x "$(command -v bash)" ]; then
    echo 'Installing brews from .brews'
    cat ./.brews | xargs brew install
fi

if [ -x "$(command -v cargo)" ]; then
    echo 'Installing Rust...'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

cat ./.cargos | xargs cargo install
