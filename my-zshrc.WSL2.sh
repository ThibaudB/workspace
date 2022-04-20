#!/bin/zsh
# Exports

# IP addresses for currently running Linux and Windows systems
LINUX_IP=$(ip addr | awk '/inet / && !/127.0.0.1/ {split($2,a,"/"); print a[1]}')
WINDOWS_IP=$(ip route | awk '/^default/ {print $3}')

# IP addresses in current windows defender firewall rule
# netsh outputs line of "^(Local|Remote)IP:\s+IPADDR/32$" so get second field of
# 'IPADDR/32' and split it on '/' then just print IPADDR
FIREWALL_WINDOWS_IP=$(netsh.exe advfirewall firewall show rule name=X11-Forwarding | awk '/^LocalIP/ {split($2,a,"/");print a[1]}')
FIREWALL_LINUX_IP=$(netsh.exe advfirewall firewall show rule name=X11-Forwarding | awk '/^RemoteIP/ {split($2,a,"/");print a[1]}')

# Update firewall rule if firewall rules IPs don't match actual ones
if [ "$FIREWALL_LINUX_IP" != "$LINUX_IP" ] || [ "$WINDOWS_IP" != "$FIREWALL_WINDOWS_IP" ]; then
	powershell.exe -Command "Start-Process netsh.exe -ArgumentList \"advfirewall firewall set rule name=X11-Forwarding new localip=$WINDOWS_IP remoteip=$LINUX_IP \" -Verb RunAs"
fi

# Appropriately set DISPLAY to Windows X11 server
DISPLAY="$WINDOWS_IP:0"

# Tell X11 programs to render on Windows, not linux, side
# docs: https://docs.mesa3d.org/envvars.html
LIBGL_ALWAYS_INDIRECT=1

export DISPLAY LIBGL_ALWAYS_INDIRECT

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
run_once sudo /etc/init.d/dbus start &> /dev/null
