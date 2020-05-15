# Global
alias -g F='| fzf'
alias -g L='| less -iFR'
alias -g LL='2>&1 | less -iFR'

# accurev
if [ -x "$(command -v accurev)" ] && [ -z $TMUX ]; then
  alias adiffd=$'accurev stat -d | awk \'{print $1}\' | xargs -n 1 -p accurev diff -j'
  alias adiffm=$'accurev stat -m | awk \'{print $1}\' | xargs -n 1 -p accurev diff'
  alias apurge=$'accurev stat -m | awk \'{print $1}\' | xargs -n 1 -p accurev purge'
fi

# Edit vim config
alias nvconfig="$EDITOR $HOME/.vim/vimrc"

# ranger
alias r='ranger'
