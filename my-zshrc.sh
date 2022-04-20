#!/bin/sh

cd $MYZSH_DIR

git pull

cd -

source $MYZSH_DIR/my-zshrc.global.sh
