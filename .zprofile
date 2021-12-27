. "$HOME/.cargo/env"
if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  exec sway -d > ~/sway.log 2>&1
  eval $(gnome-keyring-daemon --start)
  export SSH_AUTH_SOCK
fi
