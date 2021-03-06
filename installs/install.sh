#!/bin/sh

MYZSH_DIR="$HOME/$1"
MYZSH_FILES_DIR="$MYZSH_DIR/files"
MYZSH_SCRIPTS_DIR="$MYZSH_DIR/scripts"

OS=`$MYZSH_SCRIPTS_DIR/os`

sudo apt-get update

git clone git@github.com:ThibaudB/workspace.git $1

sudo apt-get install "$MYZSH_DIR/packages.txt"

# Configure Python3 as default python
if [[ `python --version` == 'Python 2.'* ]]; then
  sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
  sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
fi;

# Tools
pip install Jinja2

# Create bind and add source into the .zshrc

# Enhance vim display
ln -s "$MYZSH_DIR/files/.vimrc" "$HOME/.vimrc"
