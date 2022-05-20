# bat
export BAT_THEME='Gruvbox-N'

# direnv
# export DIRENV_LOG_FORMAT=""

# fzf
export DISABLE_FZF_AUTO_COMPLETION='false'
export DISABLE_FZF_KEY_BINDINGS='false'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always {}' \
    --history=$HOME/.fzf_history --preview-window hidden \
    --bind 'alt-a:toggle-all,alt-h:toggle-preview' --cycle"

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
# export SKIM_DEFAULT_COMMAND='fd --type f --hidden --follow'
# export SKIM_DEFAULT_OPTIONS="--multi --preview-window=':hidden' --preview='bat --style=numbers --color=always {}' --cmd-history=$HOME/.skim_cmd_history --history=$HOME/.skim_history --bind='alt-a:toggle-all,alt-h:toggle-preview'"

# zsh-autosuggestions
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
