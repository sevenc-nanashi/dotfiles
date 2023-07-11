#!/usr/bin/env bash

git clone https://github.com/sevenc-nanashi/dotfiles ~/dotfiles

cd ~/dotfiles
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local

ln -s ~/dotfiles/.bashrc ~/.bashrc
ln -s ~/dotfiles/neovim/ ~/.config/nvim
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml
