# accurev
if [ -x "$(command -v accurev)" ]; then
  function adiffd() {
    modified="$(accurev stat -d | awk '{print $1}')"
    echo $modified | sk -m --preview-window='right:50%' --preview='temp=$(AC_DIFF_CLI="/usr/bin/diff --color=always -u %1 %2" accurev diff -j {}); echo $temp' --bind 'alt-enter:execute(accurev diff -j {})'
  }

  function adiffm() {
    modified="$(accurev stat -m | awk '{print $1}')"
    echo $modified | sk -m --preview-window='right:50%' --preview='temp=$(AC_DIFF_CLI="/usr/bin/diff --color=always -u %1 %2" accurev diff {}); echo $temp' --bind 'alt-enter:execute(accurev diff {})'
  }

  function apop() {
      mkdir -p "$1" && accurev pop -L "$1" -R -v "$2" .
  }
fi

# skim
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
