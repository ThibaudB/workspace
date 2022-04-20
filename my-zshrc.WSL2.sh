#!/bin/zsh
# Exports
# set DISPLAY variable to the IP automatically assigned to WSL2
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

# We're just modifying unreadable default ln color
eval `dircolors ~/.dir_colors`

#Alias
alias explorer="explorer.exe `pwd -P`"
alias cmd="cmd.exe"
alias gitk="gitk.exe"
alias gitg="git-gui.exe"
alias curl="curl -k"
alias clip="clip.exe"

alias apt-get-list="zcat /var/log/apt/history.log.*.gz | cat - /var/log/apt/history.log | grep -Po '^Commandline: apt-get install (?!.*--reinstall)\K.*' | sort"

export vsc = function () {
  cd -P `dirname $1`
  debug_exec "'/mnt/c/Users/thibaud.buchs/AppData/Local/Programs/Microsoft VS Code/Code.exe' -r `basename $1`"
  cd -
}

export winget = function () { 
  cmd.exe /c "winget $1 $2 $3";
}

export pass = function () {
  /usr/bin/pass $@ | clip
}

alias ll="ls -al"
alias lw="ls -1 | wc -l"
alias pidForPort="netstat -vanp tcp | grep "

# Automatically start dbus
sudo /etc/init.d/dbus start &> /dev/null

DOCKER_DISTRO="Ubuntu"
DOCKER_DIR=/mnt/wsl/shared-docker
DOCKER_SOCK="$DOCKER_DIR/docker.sock"
export DOCKER_HOST="unix://$DOCKER_SOCK"
if [ ! -S "$DOCKER_SOCK" ]; then
   mkdir -pm o=,ug=rwx "$DOCKER_DIR"
   chgrp docker "$DOCKER_DIR"
   /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd > $DOCKER_DIR/dockerd.log 2>&1"
fi
