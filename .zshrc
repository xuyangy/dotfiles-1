ZSH="/usr/share/oh-my-zsh"
ZSH_THEME="flazz"
plugins=(git safe-paste zsh-vi-mode fasd npm)
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:$HOME/.npm-global/bin:/usr/local/bin:/snap/bin:~/.dotnet/tools:$PATH

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

KEYTIMEOUT=1
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

alias sai="sudo apt install"
alias ni="npm install"
alias nrs="npm run serve"
alias config="/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"

fasd_cache="$HOME/.fasd-init-zsh"
# fasd init
eval "$(fasd --init auto)"
