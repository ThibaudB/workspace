#!/bin/zsh

export FUNCTION="$MYZSH_DIR/functions"

for src in `ls $FUNCTION/*`; do
  source $src
done;

export debug-exec = function () {
  [[ -v DEBUG ]] && [ "$DEBUG" -ge ${2:-1} ] && echo "-- DEBUG -- $1"
  eval "$1"
}

export reload-env-var = function () {
  save_var="DEFAULT_$1"
  debug=`[ -v DEBUG ] && [ "$DEBUG" -ge '1' ]`
  if [ -v ${save_var} ]; then
    debug-exec "export \"${1}\"=\"${(P)save_var}\"" 1
  else
    debug-exec "export \"${save_var}\"=\"${(P)1}\"" 1
  fi;
}

# Reset PATH to initial PATH
reload-env-var PATH
export PATH="$PATH:$MYZSH_DIR/bin"

# Exports
export PROFILE="$HOME/.zshrc"
export WORKSPACE="$HOME/workspace"
export APP="$WORKSPACE/app"
export EDITOR='vi'

# Alias
alias reload="source $MYZSH_DIR/my-zshrc.sh"

os_configuration="$MYZSH_DIR/my-zshrc."`os`".sh"
if [ -f $os_configuration ] ; then
  debug-exec "source '$os_configuration'"
fi
