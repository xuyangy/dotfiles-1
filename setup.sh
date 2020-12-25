set -x
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

#nvim
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

ln -s -f ~/dotfiles/init.vim ~/.config/nvim/init.vim
ln -s -f ~/dotfiles/.bashrc ~/.bashrc 
ln -s -f ~/dotfiles/.zshrc ~/.bashrc 
ln -s -f ~/dotfiles/.bash_aliases ~/.bash_aliases 
ln -s -f ~/dotfiles/.gitconfig ~/.gitconfig 

nvm install 12
