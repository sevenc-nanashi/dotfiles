#!/usr/bin/env bash
set -ex

if command -v curl >/dev/null 2>&1; then
    echo "curl is already installed."
else
    echo "curl is not installed!"
    exit 1
fi

curl https://mise.run | sh

if [ -n "$DOTFILES_INSTALLER_PATH" ]; then
    echo "Using provided DOTFILES_INSTALLER_PATH: $DOTFILES_INSTALLER_PATH"
else
    DOTFILES_INSTALLER_PATH=/tmp/sevenc-nanashi_dotfiles_install.nu
    echo "Downloading dotfiles installer to $DOTFILES_INSTALLER_PATH"
    curl https://github.com/sevenc-nanashi/dotfiles/raw/main/install.nu -Lo "$DOTFILES_INSTALLER_PATH"
fi

export MISE_PATH=$HOME/.local/bin/mise

$MISE_PATH x github:nushell/nushell -- nu "$DOTFILES_INSTALLER_PATH"
