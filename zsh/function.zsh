# skim
function cdd() {
  cd "${$(fd --type d --hidden --follow --no-ignore '' ${1:-.} | sk):-.}"
}

function fh() {
  print -z "$( ([ -n $ZSH_NAME ] && fc -l 1 || history) | sk --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')"
}

function fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi

  rg --files-with-matches --no-messages "$1" $2 | sk -m --bind 'alt-enter:execute($EDITOR -p {})' --preview "bat --style=numbers --color=always {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

function fkill() {
  local pid 
  if [ "$UID" != "0" ]; then
    pid="$(ps -f -u $UID | sed 1d | sk -m | awk '{print $2}')"
  else
    pid="$(ps -ef | sed 1d | sk -m | awk '{print $2}')"
  fi  

  if [ "x$pid" != "x" ]
  then
    echo "$pid" | xargs kill -"${1:-9}"
  fi  
}

function j() {
  local destination="$(fasd -s -d | sk --tac -n 2 ${1:+-q $1} | awk '{print $2}')"
  cd "${destination-$(pwd)}"
}

function _skim_compgen_path() {
  echo "$1"
  command fd -H -L \
    -E '.git/*' -E '.hg/*' -E '.svn/*' -t f -t d -t l \
    -p --no-ignore --no-ignore-vcs "$1" "$1" 2> /dev/null | sed 's@^\./@@'
}

function _skim_compgen_dir() {
  command fd -H -L \
    -E '.git/*' -E '.hg/*' -E '.svn/*' -t d \
    -p --no-ignore --no-ignore-vcs "$1" "$1" 2> /dev/null | sed 's@^\./@@'
}

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
