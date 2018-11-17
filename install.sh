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

mkdir ~/.fonts
cp awesome-terminal-fonts/build ~/.fonts
fc-cache -fv ~/.fonts 
