# globals
if [[ -x "$(whence -p bat)" ]]; then
  alias -g B='| bat'
  alias -g BB='|& bat'
fi
if [[ -x "$(whence -p fzf)" ]]; then alias -g F='| fzf'; fi
alias -g L='| less -iR'
alias -g LL='|& less -iR'
if [[ -x "$(whence -p sk)" ]]; then alias -g S='| sk'; fi

# general
if [[ -x "$(whence -p howdoi)" ]]; then
  if [[ -x "$(whence -p bat)" ]]; then
    alias h='function hdi(){ howdoi $* -c -n 5 | bat; }; hdi'
  else
    alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
  fi
fi
alias dl='dirs -lv'
alias dv='dirs -v'
alias nvconfig="$EDITOR $HOME/.vim/vimrc"

# ls replacements
if [[ -x "$(whence -p lsd)" ]] && lsd >/dev/null 2>&1; then
  alias l='lsd -AFl --group-dirs first --color always'
  alias la='lsd -AF --group-dirs first --color always'
  alias ll='lsd -Fl --group-dirs first --color always'
  alias ls='lsd -F --group-dirs first --color always'
  alias lt='lsd -AF --tree --group-dirs first --color always'
elif [[ -x "$(whence -p colorls)" ]] && colorls >/dev/null 2>&1; then
  alias l='colorls -Al --sd --gs --dark'
  alias la='colorls -A --sd --gs --dark'
  alias ld='colorls -Ald --sd --gs --dark'
  alias lf='colorls -Alf --sd --gs --dark'
  alias ll='colorls -l --sd --gs --dark'
  alias ls='colorls --sd --gs --dark'
  alias lt='colorls -A --tree --sd --gs --dark'
elif [[ -x "$(whence -p exa)" ]] && exa >/dev/null 2>&1; then
  alias l='exa -al --color=always --group-directories-first'
  alias la='exa -a --color=always --group-directories-first'
  alias ll='exa -l --color=always --group-directories-first'
  alias ls='exa --color=always --group-directories-first'
  alias lt='exa -aT --color=always --group-directories-first'
fi

# ranger
if [[ -x "$(whence -p ranger)" ]]; then alias r='ranger'; fi

# skim
if [[ -x "$(whence -p sk)" ]]; then
  alias nve='$EDITOR $(sk)'
fi

# watson
if [[ -x "$(whence -p watson)" ]]; then
  alias watson='watson --color'
  alias wl='watson log'
  alias wld='watson log --day'
  alias wlw='watson log --week'
  alias wr='watson report'
  alias wrd='watson report --day'
  alias wrw='watson report --week'
  alias wswap='watson stop && watson start --no-gap'
fi

# unalias
if [[ -x "$(whence -p fd)" && -n "$(alias -m 'fd')" ]]; then unalias fd; fi
