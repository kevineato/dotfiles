# Global
if [ -x "$(command -v bat)" ]; then alias -g B='| bat'; fi
if [ -x "$(command -v fzf)" ]; then alias -g F='| fzf'; fi
alias -g L='| less -iR'
alias -g LL='2>&1 | less -iR'
if [ -x "$(command -v sk)" ]; then alias -g S='| sk'; fi

# General
if [ -x "$(command -v howdoi)" ]; then
  if [ -x "$(command -v bat)" ]; then
    alias h='function hdi(){ howdoi $* -c -n 5 | bat; }; hdi'
  else
    alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
  fi
fi
alias nvconfig="$EDITOR $HOME/.vim/vimrc"

# ranger
if [ -x "$(command -v accurev)" ]; then alias r='ranger'; fi

# skim
if [ -x "$(command -v sk)" ]; then
  alias nve='$EDITOR $(sk)'
fi

# unalias
if [ -n "$(alias -m 'fd')" ]; then unalias fd; fi
if [ -n "$(alias -m 'ff')" ]; then unalias ff; fi
