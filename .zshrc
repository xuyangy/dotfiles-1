ZSH="/usr/share/oh-my-zsh/"
ZSH_THEME="flazz"
plugins=(git safe-paste zsh-vi-mode autojump npm)
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:$HOME/.npm-global/bin:/usr/local/bin:/snap/bin:~/.dotnet/tools:$PATH

export NVM_DIR=~/.nvm
source /usr/share/nvm/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

KEYTIMEOUT=1
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

alias sai="sudo apt install"
alias ni="npm install"
alias nrs="npm run serve"
alias config="/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"

# autojump
[[ -s /home/artur/.autojump/etc/profile.d/autojump.sh ]] && source /home/artur/.autojump/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u


bindkey -v

