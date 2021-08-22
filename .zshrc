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

alias v="f -e nvim"
function vd() {
  fasd_cd -d "$1" && nvim
}
alias nrs="npm run serve"
alias config="/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME"
alias vi="nvim"
alias spacy="python -m spacy"
alias weather="curl wttr.in"

fasd_cache="$HOME/.fasd-init-zsh"
# fasd init
eval "$(fasd --init auto)"

ranger_cd() {
  temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
  ranger --choosedir="$temp_file" -- "${@:-$PWD}"
  if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
    cd -- "$chosen_dir"
  fi
  rm -f -- "$temp_file"
}
bindkey -s '\eOP' "ranger_cd\n" # f1

