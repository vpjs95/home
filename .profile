#!/bin/sh

. ~/.pathrc
export LANG=en_US.utf8
export XDG_DESKTOP_DIR=$HOME
export XDG_DOWNLOAD_DIR=$HOME/get
export XAUTHORITY=$HOME/.Xauthority
test -d /var/host/cras && export CROUTON=1

# use ChromeOS' existing X11 server when inside crouton
if test -z "$DISPLAY" -a -n "$CROUTON" ; then
  export XAUTHORITY=/var/host/Xauthority
  export DISPLAY=:0.0
fi

# use all processors for fast, parallel make(1) builds
export MAKEFLAGS="-j$(fgrep -c processor /proc/cpuinfo)"

# start X when logging into the first Virtual Terminal
# https://wiki.archlinux.org/index.php/Start_X_at_Login
test -z "$DISPLAY" -a "$(tty)" = /dev/tty1 && exec startx

# reattach last tmux session after logging in through SSH
# unless we are logging into the same machine from itself
test -z "$TMUX" -a -n "$SSH_CONNECTION" &&
echo "$SSH_CONNECTION" | awk '{ exit $1 == $3 }' &&
{ tmux has-session && tmux attach -d || tmux -2 ;}
