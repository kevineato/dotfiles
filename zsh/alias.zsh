# Global
alias -g F='| fzf'
alias -g L='| less -iFR'
alias -g LL='2>&1 | less -iFR'
alias -g S='| sk'

# edit vim config
alias nvconfig="$EDITOR $HOME/.vim/vimrc"

# ranger
if [ -x "$(command -v accurev)" ]; then alias r='ranger'; fi

# skim
alias cdd='cd ${$(fd -H -I -t d | sk):-.}'
alias nve='$EDITOR $(sk -m)'

# unalias
if [ -n "$(alias -m 'fd')" ]; then unalias fd; fi
if [ -n "$(alias -m 'ff')" ]; then unalias ff; fi
