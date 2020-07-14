# globals
if [[ -x "$(command -v bat)" ]]; then alias -g B='| bat'; fi
if [[ -x "$(command -v fzf)" ]]; then alias -g F='| fzf'; fi
alias -g L='| less -iR'
alias -g LL='2>&1 | less -iR'
if [[ -x "$(command -v sk)" ]]; then alias -g S='| sk'; fi

# general
if [[ -x "$(command -v howdoi)" ]]; then
  if [[ -x "$(command -v bat)" ]]; then
    alias h='function hdi(){ howdoi $* -c -n 5 | bat; }; hdi'
  else
    alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
  fi
fi
alias nvconfig="$EDITOR $HOME/.vim/vimrc"

# ls replacements
if [[ -x "$(command -v lsd)" ]]; then
  alias l='lsd -AFl --group-dirs first --color always'
  alias la='lsd -AF --group-dirs first --color always'
  alias ll='lsd -Fl --group-dirs first --color always'
  alias ls='lsd -F --group-dirs first --color always'
  alias lt='lsd -AF --tree --group-dirs first --color always'
elif [[ -x "$(command -v colorls)" ]]; then
  alias l='colorls -Al --sd --gs --dark'
  alias la='colorls -A --sd --gs --dark'
  alias ld='colorls -Ald --sd --gs --dark'
  alias lf='colorls -Alf --sd --gs --dark'
  alias ll='colorls -l --sd --gs --dark'
  alias ls='colorls --sd --gs --dark'
  alias lt='colorls -A --tree --sd --gs --dark'
elif [[ -x "$(command -v exa)" ]]; then
  alias l='exa -al --color=always --group-directories-first'
  alias la='exa -a --color=always --group-directories-first'
  alias ll='exa -l --color=always --group-directories-first'
  alias ls='exa --color=always --group-directories-first'
  alias lt='exa -aT --color=always --group-directories-first'
fi

# ranger
if [[ -x "$(command -v accurev)" ]]; then alias r='ranger'; fi

# skim
if [[ -x "$(command -v sk)" ]]; then
  if [[ -x "$(command -v fasd)" ]]; then
    alias j='cd $(fasd -s -d | sk --tac -n 2 | awk '\''{print $2}'\'')'
  fi
  alias nve='$EDITOR $(sk)'
fi

# watson
if [[ -x "$(command -v watson)" ]]; then
  alias watson='watson --color'
fi

# unalias
if [[ "$(command -pv fd)" && -n "$(alias -m 'fd')" ]]; then unalias fd; fi
