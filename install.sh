#!/bin/bash
# File: install.sh
# Description: Installs configuration files from this repo.
# Maintainer: Jack Sol

if [ ! -x "$(command -v brew)" ]; then
    echo 'Installing Homebrew...'
    mkdir -p ~/.brew
    git clone 'https://github.com/Homebrew/brew.git' ~/.brew

    echo 'Adding homebrew to your path'
    if [ -w ~/.bashrc ]; then
        echo '# Add brew to the path' >> ~/.bashrc
        echo 'export PATH=$HOME/.brew/bin:$PATH' >> ~/.bashrc
    fi
    if [ -w ~/.zshrc ]; then
        echo '# Add brew to the path' >> ~/.zshrc
        echo 'export PATH=$HOME/.brew/bin:$PATH' >> ~/.bashrc
    fi
fi

echo 'Installing brews from .brews'
cat ./.brews | xargs ~/.brew/bin/brew install

if [ -x "$(command -v cargo)" ]; then
    echo 'Installing Rust...'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    echo 'Adding Rust to your path'
    if [ -w ~/.bashrc ]; then
        echo '# Add rust to the path' >> ~/.bashrc
        echo 'export PATH=$HOME/.cargo/bin:$PATH' >> ~/.bashrc
    fi
    if [ -w ~/.zshrc ]; then
        echo '# Add rust to the path' >> ~/.zshrc
        echo 'export PATH=$HOME/.cargo/bin:$PATH' >> ~/.bashrc
    fi
fi

echo 'Installing crates from .crates'
cat ./.crates | xargs ~/.cargo/bin/cargo install

if [ ! -e ~/repos/zsh-syntax-highlighting ]; then
    echo "Installing zsh-syntax-highlighting..."
    mkdir -p ~/repos
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/repos/zsh-syntax-highlighting
    echo "# Enable syntax highlighting" >> ~/.zshrc
    echo "source ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
fi

echo 'To use the installed tools, restart your terminal or do:'
echo '  bash: source ~/.bashrc'
echo '  zsh: source ~/.zshrc'
