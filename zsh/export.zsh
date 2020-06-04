# Check for accurev
if [ -x "$HOME/AccuRevClient/bin/accurev" ]; then
  export AC_DIFF_CLI="nvim -d %1 %2"
  if [ -z "$TERMUX" ]; then
    export PATH="$PATH:$HOME/AccuRevClient/bin"
  fi
fi

# Check for skim
if [ -x "$HOME/.skim/bin/sk" ]; then
  if [ -z "$TERMUX" ]; then
    export PATH="$HOME/.skim/bin:$PATH"
  fi
fi

# Only ammend $PATH if not in tmux
if [ -z "$TMUX" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# bat
export BAT_THEME='Gruvbox-N'

# fzf
export DISABLE_FZF_AUTO_COMPLETION='false'
export DISABLE_FZF_KEY_BINDINGS='false'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --ignore-file '~/.fdignore'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--preview 'bat --style=numbers --color=always' --history=$HOME/.fzf_history --bind 'alt-a:toggle-all'"

# General
export EDITOR='nvim'
export LESS='iFR'
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
export SKIM_DEFAULT_COMMAND="fd --type f --hidden --follow --ignore-file '~/.fdignore'"
export SKIM_DEFAULT_OPTIONS="--multi --preview-window=':hidden' --preview='bat --style=numbers --color=always {}' --cmd-history=$HOME/.skim_cmd_history --history=$HOME/.skim_history --bind='alt-a:toggle-all,alt-h:toggle-preview'"
