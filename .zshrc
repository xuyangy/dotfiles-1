plugins=(git safe-paste vi-mode autojump npm)
ZSH="/usr/share/oh-my-zsh/"
ZSH_THEME="cypher"
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:$HOME/.npm-global/bin:/usr/local/bin:/snap/bin:~/.dotnet/tools:$PATH

KEYTIMEOUT=10
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

alias sai="sudo apt install"
alias ni="npm install"
alias nrs="npm run serve"
alias vi="nvim"
alias vim="nvim"
alias oldvim="\vim"

# autojump
[[ -s /home/artur/.autojump/etc/profile.d/autojump.sh ]] && source /home/artur/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login
# if command -v tmux >/dev/null 2>&1 && [ "${DISPLAY}" ]; then
    # if not inside a tmux session, and if no session is started, start a new session
    # [ -z "${TMUX}" ] && (tmux attach || tmux) >/dev/null 2>&1
#fi


function vi_mode_prompt_info() {
  echo "${${KEYMAP/vicmd/[% NORMAL]%}/(main|viins)/[% INSERT]%}"
}

# https://stratus3d.com/blog/2017/10/26/better-vi-mode-in-zshell/#mode-indicator
# define right prompt, regardless of whether the theme defined it
RPS1='$(vi_mode_prompt_info)'
RPS2=$RPS1

# https://stackoverflow.com/a/49079378/10706046
function pip-install-save { 
    pip install $1 && pip freeze | grep $1 >> requirements.txt
}
