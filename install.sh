#!/bin/bash
# File: install.sh
# Description: Installs configuration files from this repo.
# Maintainer: Jack Sol

# Installs brew to the home directory
if [ ! -x "$(command -v brew)" ]; then
    echo 'Installing Homebrew...'
    mkdir -p ~/.brew
    git clone 'https://github.com/Homebrew/brew.git' ~/.brew

    echo 'Adding homebrew to your path'
    if [ -w ~/.bashrc ]; then
        echo '' >> ~/.bashrc
        echo '# Add brew to the path' >> ~/.bashrc
        echo 'export PATH=$HOME/.brew/bin:$PATH' >> ~/.bashrc
    fi
    if [ -w ~/.zshrc ]; then
        echo '' >> ~/.zshrc
        echo '# Add brew to the path' >> ~/.zshrc
        echo 'export PATH=$HOME/.brew/bin:$PATH' >> ~/.bashrc
    fi
fi

echo 'Installing brews from .brews'
cat ./.brews | xargs ~/.brew/bin/brew install

# Installs Rust to the home directory
if [ -x "$(command -v cargo)" ]; then
    echo 'Installing Rust...'
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    echo 'Adding Rust to your path'
    if [ -w ~/.bashrc ]; then
        echo '' >> ~/.bashrc
        echo '# Add rust to the path' >> ~/.bashrc
        echo 'export PATH=$HOME/.cargo/bin:$PATH' >> ~/.bashrc
    fi
    if [ -w ~/.zshrc ]; then
        echo '' >> ~/.zshrc
        echo '# Add rust to the path' >> ~/.zshrc
        echo 'export PATH=$HOME/.cargo/bin:$PATH' >> ~/.zshrc
    fi
fi

echo 'Installing crates from .crates'
cat ./.crates | xargs ~/.cargo/bin/cargo install

if [ ! -e ~/repos/zsh-syntax-highlighting ]; then
    echo 'Installing zsh-syntax-highlighting...'
    mkdir -p ~/repos
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/repos/zsh-syntax-highlighting
    echo '' >> ~/.zshrc
    echo '# Enable syntax highlighting' >> ~/.zshrc
    echo 'source ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
fi

# Installs neovim config
if [ ! -L ~/.config/nvim ]; then
    echo 'Installing neovim configuration...'
    ln -s $PWD/.config/nvim/init.vim ~/.config/nvim/init.vim
    ln -s $PWD/.config/nvim/ftplugin/ ~/.config/nvim/ftplugin/
    ln -s $PWD/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
fi

# Installs starship config
if [ ! -L ~/.config/starship.toml ]; then
    echo 'Installing Starship configuration...'
    ln -s `pwd`/.config/starship.toml ~/.config/starship.toml
fi

# Install nvim plugins silently
echo 'Installing NeoVim plugins...'
nvim --headless +"PlugInstall" +"qall!"

# Install coc plugins
echo 'Installing CoC plugins...'
nvim --headless +'CocInstall -sync coc-json coc-explorer coc-python' +qall

echo ''
echo 'To use the installed tools, restart your terminal or do:'
echo '  bash: source ~/.bashrc'
echo '  zsh: source ~/.zshrc'
