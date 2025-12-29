#!/usr/bin/env bash
set -eux

function link() {
  if [ -e $2 ]; then
    mv $2 $2.bak
  fi
  mkdir -p $(dirname $2)
  ln -s $(realpath $1) $2
}

git clone https://github.com/sevenc-nanashi/dotfiles ~/dotfiles

sudo apt update
sudo apt install -y unzip curl git make build-essential gnupg2

cd ~/dotfiles
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim

curl https://mise.run | bash
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

source ~/.bashrc

link ~/dotfiles/.bashrc ~/.bashrc
link ~/dotfiles/neovim/ ~/.config/nvim
link ~/dotfiles/global-package.json ~/.bun/install/global/package.json
link ~/dotfiles/.gitconfig ~/.gitconfig
link ~/dotfiles/.gitignore_global ~/.gitignore_global
link ~/dotfiles/starship.toml ~/.config/starship.toml
link ~/dotfiles/bat.config ~/.config/bat/config
link ~/dotfiles/gh.config.yml ~/.config/gh/config.yml
link ~/dotfiles/mise ~/.config/mise
link ~/dotfiles/nushell/ ~/.config/nushell

for file in ~/dotfiles/bin/*; do
  link $file ~/.local/bin/$(basename $file)
done

git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local

cd ~
