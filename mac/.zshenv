export PATH=$HOME/bin:$HOME/.npm-global/bin:/usr/local/bin:/snap/bin:$HOME/.dotnet/tools:$HOME/.local/bin:$HOME/.emacs.d/bin:$PATH
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
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi
