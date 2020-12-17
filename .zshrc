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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/opt/ruby/bin:$PATH"

# --------
# Behavior
# --------

# Vi mode
bindkey -v
export KEYTIMEOUT=1
