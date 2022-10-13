# fzf
if [[ -x "$(whence -p fzf)" ]]; then
    function cdd() {
        local input_dir=${1:-.}
        local directory="$(fd --type d --hidden --no-ignore '' $input_dir | \
            awk -F / -v input_dir=$input_dir '{ print NF, $0 }' | \
            sort -k 1n,1 -k 2d,2 -s | \
            cut -d ' ' -f 2- | \
            sed -n -e '/^\.$/ d' -e '{s/^\.\///; p;}' | \
            fzf --no-multi --exit-0 --height 40% --reverse --bind 'tab:down,shift-tab:up')"
        if [[ -n $directory ]]; then
            cd $directory
        fi
    }

    function cdl() {
        local directory="$(dirs -lv | \
            sed -n -e '1 ! p' | \
            fzf --no-multi --height 40% --reverse --bind 'tab:down,shift-tab:up' | \
            cut -f 2)"
        if [[ -n $directory ]]; then
            cd $directory
        fi
    }

    function cdv() {
        local directory="$(dirs -v | \
            sed -n -e '1 ! p' | \
            fzf --no-multi --height 40% --reverse --bind 'tab:down,shift-tab:up' | \
            cut -f 2 | \
            sed -E "s@~@$HOME@")"
        if [[ -n $directory ]]; then
            cd $directory
        fi
    }

    function nve() {
        local files="$(fd --type f --hidden --follow --no-ignore '' ${1:-.} | fzf)"
        $EDITOR ${files:+"${(ps.\n.)files}"}
    }

    function fh() {
        print -z "$( ([ -n $ZSH_NAME ] && fc -l 1 || history) | \
            fzf --tac | \
            sed -r 's/ *[0-9]*\*? *//' | \
            sed -r 's/\\/\\\\/g')"
    }

    function fif() {
        if [ ! "$#" -gt 0 ]; then
            echo "Need a string to search for!"
            return 1
        fi

        rg --files-with-matches --no-messages "$1" $2 | \
            fzf --multi --bind 'alt-enter:execute($EDITOR -p {})' --preview "bat --style=numbers --color=always {} 2> /dev/null | \
            rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
    }

    function fkill() {
        local pid
        if [ "$UID" != "0" ]; then
            pid="$(ps -f -u $UID | sed 1d | fzf --multi | awk '{print $2}')"
        else
            pid="$(ps -ef | sed 1d | fzf --multi | awk '{print $2}')"
        fi

        if [ "x$pid" != "x" ]; then
            echo "$pid" | xargs kill -"${1:-9}"
        fi
    }

    if [[ -n "$(alias -m 'j')" ]]; then unalias j; fi
    function j() {
        local destination="$(fasd -s -d | fzf --tac -n 2 ${1:+-q $1} | awk '{print $2}')"
        cd "${destination-$(pwd)}"
    }

    # function _skim_compgen_path() {
    #     echo "$1"
    #     command fd -H -L \
    #         -E '.git/*' -E '.hg/*' -E '.svn/*' -t f -t d -t l \
    #         -p --no-ignore --no-ignore-vcs "$1" "$1" 2> /dev/null | sed 's@^\./@@'
    # }
    #
    # function _skim_compgen_dir() {
    #     command fd -H -L \
    #         -E '.git/*' -E '.hg/*' -E '.svn/*' -t d \
    #         -p --no-ignore --no-ignore-vcs "$1" "$1" 2> /dev/null | sed 's@^\./@@'
    # }
fi

# nnn
if [[ -x "$(whence -p nnn)" ]]; then
    nnn_cd()
    {
        # Block nesting of nnn in subshells
        if [[ "${NNNLVL:-0}" -ge 1 ]]; then
            echo "nnn is already running"
            return
        fi

        # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
        # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
        # see. To cd on quit only on ^G, remove the "export" and make sure not to
        # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
        #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
        NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

        # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
        # stty start undef
        # stty stop undef
        # stty lwrap undef
        # stty lnext undef

        # The backslash allows one to alias n to nnn if desired without making an
        # infinitely recursive alias
        \nnn "$@"

        if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
        fi
    }

    alias -g n='nnn_cd -deHAJiU'
fi

# _complete_plus_hist_args() {
# local query q_commands q_commands_array q_commands_arr
# query=(${(s/ /)BUFFER})
# query="$query[1]"
# q_commands=$(print -l -- ${${(v)history[(R)*$query*]}//( |)$query( |)/})
# q_command_array=$(print -r -- $q_commands | awk '/^--?\S+ \S+/{split($0, t, /(--?\S+ \S+)/, m); for (i=1; i in m; i++) print m[i];}' | sort -u)
# q_command_arr=(${(@f)q_command_array})
# compadd -a -Q q_command_arr
# _complete
# }

# _force_rehash() {
# (( CURRENT == 1  )) && rehash
# return 1
# }

# zstyle ':completion:::::' completer _force_rehash _complete_plus_hist_args _approximate
