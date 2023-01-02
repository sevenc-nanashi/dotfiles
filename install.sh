#!/usr/bin/env bash

git clone https://github.com/sevenc-nanashi/dotfiles ~/dotfiles

cd ~/dotfiles
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

ln -s ./neovim/ ~/.config/nvim
ln -s ./.gitconfig ~/.gitconfig
ln -s ./.gitignore_global ~/.gitignore_global 
ln -s ./starship.toml ~/.config/starship.toml
