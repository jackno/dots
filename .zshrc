# -------
# Plugins
# -------

# Starship prompt
eval "$(starship init zsh)"

# Fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Syntax highlighting
source ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# -------
# Aliases
# -------

alias activate='source env/bin/activate'
alias ls='exa'
