#!/bin/sh

MYZSH_DIR="$HOME/$1"
MYZSH_FILES_DIR="$MYZSH_DIR/files"
MYZSH_SCRIPTS_DIR="$MYZSH_DIR/scripts"

OS=`$MYZSH_SCRIPTS_DIR/os`

git clone git@github.com:ThibaudB/workspace.git $1

sudo apt-get update

# Tools
sudo apt-get install pip 
pip install Jinja2

sudo apt-get install git 

# Zsh
if [ $OS == "WSL2" ];
then
  sudo apt install git zsh -y
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Create bind and add source into the .zshrc

# Enhance vim display
ln -s "$MYZSH_DIR/files/.vimrc" "$HOME/.vimrc"