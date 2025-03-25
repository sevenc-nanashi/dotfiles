#!/usr/bin/env bash
set -eux

function link() {
  if [ -e $2 ]; then
    mv $2 $2.bak
  fi
  mkdir -p $(dirname $2)
  ln -s (realpath $1) $2
}

git clone https://github.com/sevenc-nanashi/dotfiles ~/dotfiles

sudo apt update
sudo apt install -y unzip curl git make build-essential gnupg2

cd ~/dotfiles
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

curl -fsSL https://bun.sh/install | bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash
curl -fsSL https://deno.land/install.sh | sh

gpg2 --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
curl -sSL https://get.rvm.io | bash -s stable
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -sSfL https://raw.githubusercontent.com/aquaproj/aqua-installer/v3.1.1/aqua-installer | bash
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

source ~/.bashrc

link ~/dotfiles/.bashrc ~/.bashrc
link ~/dotfiles/neovim/ ~/.config/nvim
link ~/dotfiles/global-package.json ~/.bun/install/global/package.json
link ~/dotfiles/.gitconfig ~/.gitconfig
link ~/dotfiles/.gitignore_global ~/.gitignore_global
link ~/dotfiles/starship.toml ~/.config/starship.toml
link ~/dotfiles/aqua.yaml ~/aqua.yaml

aqua install
bun i -g pnpm
nvm install --lts
cargo binstall -y eza

cargo install --git https://github.com/sevenc-nanashi/envcache.git
cargo install --git https://github.com/sevenc-nanashi/ccsum.git

git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local

cd ~
