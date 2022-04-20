#!/bin/sh

# Default configuration
export SYMSTORE="$HOME/.mto"

export mto = function () {
  args=($@)
  declare -a presents
  declare -A opts

  for arg in $args; do
    if [[ $arg == -* ]]; then
      opt=${arg:1}
      presents+=($opt)
    else
      if [[ -z $opt ]]; then
        opt="m"
        presents+=("m")
      fi;

      if [[ ! -z $arg ]]; then
        opts[$opt]=$arg
        unset opt
      fi;
    fi;
  done;

  if [ ${#presents[@]} -eq 0 ]; then
    presents+=("m")
  fi

  for k in ${presents[@]}; do
    v="${opts[$k]}"
    if [[ -z $v ]]; then
      v="default"
    fi

    target="$SYMSTORE/$v"

    if [[ $k == "m" ]]; then
      [ ! -d "$target" ] && echo "Path '$v' does not exist." && return 1
      debug_exec "cd -P '$target' &> /dev/null"
    elif [[ $k == "r" ]]; then
      [ ! -d "$target" ] && echo "Path '$v' does not exist." && return 1
      debug_exec "rm '$target' &> /dev/null"
    elif [[ $k == "s" ]]; then
      debug_exec "rm '$target' &> /dev/null"
      # for subdirectory creation: mkdir -p $v
      debug_exec "ln -s '`pwd`' '$target'"
    fi;
  done;
}

function _mto() {
  _arguments '-s[set]' '-r[remove]' "1:path:_path_files -W '$SYMSTORE'"
}

compdef _mto mto
