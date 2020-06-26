# PATH functions
function path_remove() {
  PATH=$(echo -n "$PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

function path_append() {
  path_remove "$1"
  PATH="${PATH:+"$PATH:"}$1"
}

function path_prepend() {
  path_remove "$1"
  PATH="$1${PATH:+":$PATH"}"
}

# Check for accurev
if [ -x "$HOME/AccuRevClient/bin/accurev" ]; then
  export AC_DIFF_CLI="nvim -d %1 %2"
  path_append "$HOME/AccuRevClient/bin"
fi

# Check for rust
if [ -d "$HOME/.cargo/bin" ]; then
    path_append "$HOME/.cargo/bin"
fi

# Check for skim
if [ -d "$HOME/.skim/bin" ]; then
    path_append "$HOME/.skim/bin"
fi

# Prepend ~/.local/bin
path_prepend "$HOME/.local/bin"

# bat
export BAT_THEME='Gruvbox-N'

# fzf
# export DISABLE_FZF_AUTO_COMPLETION='false'
# export DISABLE_FZF_KEY_BINDINGS='false'
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
# export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --ignore-file '~/.fdignore'"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always' --history=$HOME/.fzf_history --bind 'alt-a:toggle-all'"

# General
export EDITOR='nvim'
export KEYTIMEOUT=1
export LESS='iR'
if [ -x "$(command -v bat)" ]; then
  export PAGER='bat'
else
  export PAGER='less'
fi
export TIME='real %e user %U sys %S CPU %P\n'
export TZ='America/Chicago'

# GNU global
export GTAGSLABEL=pygments

# ripgrep
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# skim
export SKIM_DEFAULT_COMMAND="fd --type f --hidden --follow"
export SKIM_DEFAULT_OPTIONS="--multi --preview-window=':hidden' --preview='bat --style=numbers --color=always {}' --cmd-history=$HOME/.skim_cmd_history --history=$HOME/.skim_history --bind='alt-a:toggle-all,alt-h:toggle-preview'"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
