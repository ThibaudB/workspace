#!/bin/zsh

export FUNCTION="$MYZSH_DIR/functions"

for src in `ls $FUNCTION/*`; do
  source $src
done;

export debug_exec = function () {
  [[ -v DEBUG ]] && [ "$DEBUG" -ge ${2:-1} ] && echo "-- DEBUG -- $1"
  eval "$1"
}

export reload_env_var = function () {
  save_var="DEFAULT_$1"
  debug=`[ -v DEBUG ] && [ "$DEBUG" -ge '1' ]`
  if [ -v ${save_var} ]; then
    debug_exec "export \"${1}\"=\"${(P)save_var}\"" 1
  else
    debug_exec "export \"${save_var}\"=\"${(P)1}\"" 1
  fi;
}

# Reset PATH to initial PATH
reload_env_var PATH
export PATH="$PATH:$MYZSH_DIR/bin"

# Exports
export PROFILE="$HOME/.zshrc"
export WORKSPACE="$HOME/workspace"
export APP="$WORKSPACE/app"
export EDITOR='vi'

# Alias
alias reload="source $PROFILE"

os_configuration="$MYZSH_DIR/.zshrc."`os`
if [ -f $os_configuration ] ; then
  debug_exec "source '$os_configuration'"
fi
