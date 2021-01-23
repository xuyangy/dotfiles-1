set -x
curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt-get update
sudo apt-get install -y nodejs neovim gcc clang g++
mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vim
ln -s -f ~/dotfiles/init.vim ~/.config/nvim/init.vim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
ln -s -f ~/dotfiles/.bashrc ~/.bashrc 
ln -s -f ~/dotfiles/.zshrc ~/.bashrc 
ln -s -f ~/dotfiles/.tmux.conf ~/.tmux.conf 
ln -s -f ~/dotfiles/.bash_aliases ~/.bash_aliases 
ln -s -f ~/dotfiles/.gitconfig ~/.gitconfig 
sudo npm i -g vls typescript-language-server eslint_d @vue/cli
