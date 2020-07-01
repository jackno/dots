# -------
# Plugins
# -------

# Aliases
alias activate='source env/bin/activate'

# Starship prompt
eval "$(starship init zsh)"

# Fuzzyfind
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Syntax highlighting
source ~/repos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Rust
export PATH=~/.cargo/bin:$PATH
