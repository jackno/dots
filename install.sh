#!/bin/bash
# File: install.sh
# Description: Installs configuration files from this repo.
# Maintainer: Jack Sol

# Installs brew to the home directory
if [ ! -x "$(command -v brew)" ]; then
    echo 'Installing Homebrew...'
    mkdir -p $HOME/.brew
    git clone 'https://github.com/Homebrew/brew.git' $HOME/.brew

    echo 'Adding homebrew to your path'
    if [ -w $HOME/.bashrc ]; then
        echo '' >> $HOME/.bashrc
        echo '# Add brew to the path' >> $HOME/.bashrc
        echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.bashrc
    fi
    if [ -w $HOME/.zshrc ]; then
        echo '' >> $HOME/.zshrc
        echo '# Add brew to the path' >> $HOME/.zshrc
        echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.bashrc
    fi
fi

echo 'Installing brews from .brews'
cat $PWD/.brews | xargs $HOME/.brew/bin/brew install

# Installs Rust to the home directory
if [ -x "$(command -v cargo)" ]; then
    echo 'Installing Rust...'
    curl --proto '=https' -sSf https://sh.rustup.rs | sh

    echo 'Adding Rust to your path'
    if [ -w $HOME/.bashrc ]; then
        echo '' >> $HOME/.bashrc
        echo '# Add rust to the path' >> $HOME/.bashrc
        echo 'export PATH=$HOME/.cargo/bin:$PATH' >> $HOME/.bashrc
    fi
    if [ -w $HOME/.zshrc ]; then
        echo '' >> $HOME/.zshrc
        echo '# Add rust to the path' >> $HOME/.zshrc
        echo 'export PATH=$HOME/.cargo/bin:$PATH' >> $HOME/.zshrc
    fi
fi

echo 'Installing crates from .crates'
cat $PWD/.crates | xargs $HOME/.cargo/bin/cargo install

# Installs neovim config
if [ ! -L $HOME/.config/nvim ]; then
    echo 'Installing neovim configuration...'
    mkdir -p $HOME/.config/nvim/ftplugin
    ln -s $PWD/.config/nvim/init.vim $HOME/.config/nvim/init.vim
    ln -s $PWD/.config/nvim/ftplugin/ $HOME/.config/nvim/ftplugin/
    ln -s $PWD/.config/nvim/coc-settings.json $HOME/.config/nvim/coc-settings.json
fi

# Installs starship config
if [ ! -L $HOME/.config/starship.toml ]; then
    echo 'Installing Starship configuration...'
    ln -s $PWD/.config/starship.toml $HOME/.config/starship.toml
fi

# Install nvim plugins silently
echo 'Installing NeoVim plugins...'
nvim --headless +"PlugInstall" +"qall!"

# Install coc plugins
echo 'Installing CoC plugins...'
nvim --headless +'CocInstall -sync coc-json coc-explorer coc-python' +qall

echo ''
echo 'To use the installed tools, restart your terminal or do:'
echo '  bash: source $HOME/.bashrc'
echo '  zsh: source $HOME/.zshrc'
