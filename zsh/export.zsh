# LD_LIBRARY_PATH functions
function lib_remove() {
  LD_LIBRARY_PATH=$(echo -n "$LD_LIBRARY_PATH" | awk -v RS=: -v ORS=: "\$0 != \"$1\"" | sed 's/:$//')
}

function lib_append() {
  lib_remove "$1"
  LD_LIBRARY_PATH="${LD_LIBRARY_PATH:+"$LD_LIBRARY_PATH:"}$1"
}

function lib_prepend() {
  lib_remove "$1"
  LD_LIBRARY_PATH="$1${LD_LIBRARY_PATH:+":$LD_LIBRARY_PATH"}"
}

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

# check for ruby
if [[ -d "$HOME/.gem/ruby/2.5.0/bin" ]]; then
  path_append "$HOME/.gem/ruby/2.5.0/bin"
fi

# check for rust
if [[ -d "$HOME/.cargo/bin" ]]; then
    path_append "$HOME/.cargo/bin"
fi

# check for skim
if [[ -d "$HOME/.skim/bin" ]]; then
    path_append "$HOME/.skim/bin"
fi

# prepend
if [[ -d '/snap/bin' ]]; then
  path_prepend '/snap/bin'
fi
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

# general
export EDITOR='nvim'
export KEYTIMEOUT=1
export LESS='iR'
if [[ -x "$(whence -p bat)" ]]; then
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
export SKIM_DEFAULT_COMMAND='fd --type f --hidden --follow'
export SKIM_DEFAULT_OPTIONS="--multi --preview-window=':hidden' --preview='bat --style=numbers --color=always {}' --cmd-history=$HOME/.skim_cmd_history --history=$HOME/.skim_history --bind='alt-a:toggle-all,alt-h:toggle-preview'"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
