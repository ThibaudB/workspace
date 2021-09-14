#!/bin/sh

cd ~

type git 
if [ $? -eq 1 ]
then
  sudo apt-get install git
else
  echo "-- Skip git install"
fi

if [ ! -d ~/workspace/app/nushell ]
then
  git clone https://github.com/nushell/nushell.git
fi

cd ~/workspace/app/nushell
git pull
cd -

sudo sh -c 'echo "$HOME/.cargo/bin/nu" >> /etc/shells'
