#!/bin/sh

if [ -z $1 ]
then
    export MYZSH_DIR="$HOME/$1"
else
    export MYZSH_DIR="$HOME/.my-zsh"
fi;

sudo apt-get update

type git
if ! $?
then
    sudo apt-get install git
fi

git clone git@github.com:ThibaudB/workspace.git $1

eval $MYZSH_DIR/installs/install.sh