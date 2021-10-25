VISUAL=nvim
export EDITOR=nvim
ZSH="/usr/share/oh-my-zsh"
ZSH_THEME="flazz"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
plugins=(git safe-paste fasd npm)
source $ZSH/oh-my-zsh.sh
export PATH=$HOME/bin:$HOME/.npm-global/bin:/usr/local/bin:/snap/bin:~/.dotnet/tools::$HOME/.local/bin:$PATH

KEYTIMEOUT=1
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

function vd() {
  fasd_cd -d "$1" && nvim
}
alias nrs="npm run serve"
alias config="/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"
alias v="nvim"
alias vi="nvim"
alias spacy="python -m spacy"
alias wttr="curl -s \"wttr.in/?2nFQ&lang=pl\" | less"
alias sway="sway -d > ~/sway.log 2>&1"

fasd_cache="$HOME/.fasd-init-zsh"
# fasd init
eval "$(fasd --init auto)"

ranger_cd() {
  temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
  < $TTY ranger --choosedir="$temp_file" -- "${@:-$PWD}"
  if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
    cd -- "$chosen_dir"
  fi
  rm -f -- "$temp_file"
  zle reset-prompt
}
zle -N ranger_cd
bindkey -v 
bindkey '^R' history-incremental-search-backward
bindkey -M viins '\eOP' ranger_cd # f1


# BEGIN_KITTY_SHELL_INTEGRATION
if test -e "/usr/lib/kitty/shell-integration/kitty.zsh"; then source "/usr/lib/kitty/shell-integration/kitty.zsh"; fi
# END_KITTY_SHELL_INTEGRATION
