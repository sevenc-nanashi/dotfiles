#!/usr/bin/env bash

curl https://mise.run | sh

alias mise="$HOME/.local/bin/mise"
curl https://github.com/sevenc-nanashi/dotfiles/raw/main/install.nu -Lo /tmp/sevenc-nanashi_dotfiles_install.nu
mise x nushell -- nu /tmp/sevenc-nanashi_dotfiles_install.nu
