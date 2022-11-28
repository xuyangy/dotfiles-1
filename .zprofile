if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
  eval $(gnome-keyring-daemon --start)
  export SSH_AUTH_SOCK

  export BEMENU_OPTS="--tb '#6272a4'\
	  --tf '#f8f8f2'\
	  --fb '#282a36'\
	  --ff '#f8f8f2'\
	  --nb '#282a36'\
	  --nf '#6272a4'\
	  --hb '#44475a'\
	  --hf '#50fa7b'\
	  --sb '#44475a'\
	  --sf '#50fa7b'\
	  --scb '#282a36'\
	  --scf '#ff79c6'"

  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
  export QT_QPA_PLATFORM=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway
  exec sway #-d > /var/log/sway.log 2>&1
fi
# eval "$(/opt/homebrew/bin/brew shellenv)"

# if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
#   eval $(gnome-keyring-daemon --start)
#   export SSH_AUTH_SOCK
#   exec startx
# fi
