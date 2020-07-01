#!/bin/bash
# File: install.sh
# Description: Installs configuration files from this repo.
# Maintainer: Jack Sol

# Installs brews from .brews list
if [ -x "$(command -v bash)" ]; then
    echo 'Installing brews from .brews'
    cat `pwd`/.brews | xargs brew install
fi

# Installs .zshrc if ~/.zshrc doesn't already exist as a regular file
if [ -f ~/.zshrc ]; then
    echo 'Moving your old ~/.zshrc to ~/.zshrc.old'
    mv ~/.zshrc ~/.zshrc.old
    echo 'Installing .zshrc'
    ln -s `pwd`/.zshrc ~/.zshrc
fi

# Installs neovim config
if [ ! -L ~/.config/nvim ]; then
    echo 'Installing .config/nvim'
    ln -s `pwd`/.config/nvim ~/.config/nvim
fi

# Installs starship config
if [ ! -L ~/.config/starship.toml ]; then
    echo 'Installing .config/starship.toml'
    ln -s `pwd`/.config/starship.toml ~/.config/starship.toml
fi

# Install nvim plugins silently
echo 'Installing neovim plugins'
nvim --headless +"PlugInstall" +"qall!"

# Install coc plugins
echo 'Installing coc plugins'
nvim --headless +'CocInstall -sync coc-json coc-explorer coc-python' +qall
