#!/usr/bin/env bash
set -eux

function link() {
  if [ -e $2 ]; then
    mv $2 $2.bak
  else
    mkdir -p $(dirname $2)
    ln -s $1 $2
  fi
}

git clone https://github.com/sevenc-nanashi/dotfiles ~/dotfiles

sudo apt update
sudo apt install -y unzip curl git make build-essential

cd ~/dotfiles
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

curl -fsSL https://bun.sh/install | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
link ~/dotfiles/global-package.json ~/.bun/install/global/package.json

nvm install lts
curl -fsSL https://deno.land/install.sh | sh

gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable

git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local

link ~/dotfiles/.bashrc ~/.bashrc
link ~/dotfiles/neovim/ ~/.config/nvim

link ~/dotfiles/.gitconfig ~/.gitconfig
link ~/dotfiles/.gitignore_global ~/.gitignore_global
link ~/dotfiles/starship.toml ~/.config/starship.toml
link ~/dotfiles/aqua.yaml ~/aqua.yaml

curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.1/aqua-installer | bash

cd ~
