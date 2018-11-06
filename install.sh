#!/bin/sh

cp ./.zshrc ~/.zshrc
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
git clone https://github.com/gabrielelana/awesome-terminal-fonts.git "./" 
cp ./build ~/.fonts
fc-cache -fv ~/.fonts 
