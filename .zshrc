# -------
# Plugins
# -------

# Starship prompt
eval "$(starship init zsh)"

# Fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Rust
export PATH=$HOME/.cargo/bin:$PATH
