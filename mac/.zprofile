if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  eval $(gnome-keyring-daemon --start)
  export SSH_AUTH_SOCK
  exec sway -d > /var/log/sway.log 2>&1
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
