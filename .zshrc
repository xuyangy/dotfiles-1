export PATH=$HOME/bin:$HOME/.npm-global/bin:/usr/local/bin:/snap/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="cypher"
plugins=(git safe-paste vi-mode autojump)

KEYTIMEOUT=10
# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
source $ZSH/oh-my-zsh.sh

alias sai="sudo apt install"
alias ni="npm install"
alias vi="nvim"
alias vim="nvim"
alias oldvim="\vim"

# autojump
[[ -s /home/artur/.autojump/etc/profile.d/autojump.sh ]] && source /home/artur/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/snapd/desktop/"
