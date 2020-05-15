# Global
alias -g F='| fzf'
alias -g L='| less -iFR'
alias -g LL='2>&1 | less -iFR'

# accurev
if [ -x "$(command -v accurev)" ]; then
  alias adiffd='accurev stat -d | awk '\''{print $1}'\'' | fzf --bind '\''enter:execute(accurev diff -j {})'\'''
  alias adiffm='accurev stat -m | awk '\''{print $1}'\'' | fzf --bind '\''enter:execute(accurev diff {})'\'''
fi

# Edit vim config
alias nvconfig="$EDITOR $HOME/.vim/vimrc"

# ranger
if [ -x "$(command -v accurev)" ]; then alias r='ranger'; fi
