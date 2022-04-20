#!/bin/sh

cd $MYZSH_DIR

git fetch

origin_version=`git rev-parse origin/HEAD`

local_version=`git rev-parse HEAD`

if [ "$origin_version" != "$local_version" ] ; then
  echo "my-zsh must be updated use: my-zsh-update"
fi

cd -

source $MYZSH_DIR/my-zshrc.global.sh
