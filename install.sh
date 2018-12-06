#!/bin/sh

cp ./.zshrc ~/.zshrc
cp ./.tmux.conf ~/.tmux.conf
cp ./.vimrc ~/.vimrc
cp ./.bash_aliases ~/
cp ./.gitconfig ~/
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git 
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/sickill/vim-monokai.git && mkdir ~/.vim/colors && cp vim-monokai/colors/monokai.vim ~/.vim/colors

wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

sudo mv PowerlineSymbols.otf /usr/share/fonts/
sudo cp awesome-terminal-fonts/build /usr/share/fonts/
sudo fc-cache -fv ~/.fonts
sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/


chsh -s /bin/zsh
