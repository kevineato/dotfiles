# globals
if [[ -x "$(whence -p bat)" ]]; then
    alias -g B='| bat'
    alias -g BB='|& bat'
fi
alias -g BG='&> /dev/null &|'
if [[ -x "$(whence -p fzf)" ]]; then alias -g F='| fzf'; fi
alias -g L='| less -iFR'
alias -g LL='|& less -iFR'
# if [[ -x "$(whence -p sk)" ]]; then alias -g S='| sk'; fi

# general
if [[ -x "$(whence -p howdoi)" ]]; then
    if [[ -x "$(whence -p bat)" ]]; then
        alias h='function hdi(){ howdoi $* -c -n 5 | bat; }; hdi'
    else
        alias h='function hdi(){ howdoi $* -c -n 5; }; hdi'
    fi
fi
if [[ -x "$(whence -p lazygit)" ]]; then alias lg='lazygit'; fi
alias dl='dirs -lv'
alias dv='dirs -v'

# git
if [[ -x "$(whence -p git)" ]]; then
    alias gdf='git diff @ @{upstream}'
fi

# ls replacements
if [[ -x "$(whence -p lsd)" ]] && lsd >/dev/null 2>&1; then
    alias l='lsd -AFl --group-dirs first'
    alias la='lsd -AF --group-dirs first'
    alias ll='lsd -Fl --group-dirs first'
    alias ls='lsd -F --group-dirs first'
    alias lt='lsd -AF --tree --group-dirs first'
elif [[ -x "$(whence -p colorls)" ]] && colorls >/dev/null 2>&1; then
    alias l='colorls -Al --sd --gs --dark --color=auto'
    alias la='colorls -A --sd --gs --dark --color=auto'
    alias ld='colorls -Ald --sd --gs --dark --color=auto'
    alias lf='colorls -Alf --sd --gs --dark --color=auto'
    alias ll='colorls -l --sd --gs --dark --color=auto'
    alias ls='colorls --sd --gs --dark --color=auto'
    alias lt='colorls -A --tree --sd --gs --dark --color=auto'
elif [[ -x "$(whence -p exa)" ]] && exa >/dev/null 2>&1; then
    alias l='exa -al --group-directories-first'
    alias la='exa -a --group-directories-first'
    alias ll='exa -l --group-directories-first'
    alias ls='exa --group-directories-first'
    alias lt='exa -aT --group-directories-first'
fi

# ranger
if [[ -x "$(whence -p ranger)" ]]; then alias r='ranger'; fi

# unalias
if [[ -x "$(whence -p fd)" && -n "$(alias -m 'fd')" ]]; then unalias fd; fi
