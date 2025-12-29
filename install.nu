def link [src: string, dest: string] {
    if ($dest | path exists) {
      mv $dest $"($dest).bak"
    }
    mkdir ($dest)
    ln -s (realpath $src) $dest
}

let dotfiles_install_path = $env.DOTFILES_PATH | default "~/dotfiles"

git clone https://github.com/sevenc-nanashi/dotfiles $dotfiles_install_path

cd $dotfiles_install_path
curl -fLo ~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

link ($dotfiles_install_path | path join ".bashrc") ~/.bashrc
link ($dotfiles_install_path | path join "neovim") ~/.config/nvim
link ($dotfiles_install_path | path join ".gitconfig") ~/.gitconfig
link ($dotfiles_install_path | path join ".gitignore_global") ~/.gitignore_global
link ($dotfiles_install_path | path join "starship.toml") ~/.config/starship.toml
link ($dotfiles_install_path | path join "bat.config") ~/.config/bat/config
link ($dotfiles_install_path | path join "gh.config.yml") ~/.config/gh/config.yml
link ($dotfiles_install_path | path join "mise") ~/.config/mise
link ($dotfiles_install_path | path join "nushell") ~/.config/nushell
link ($dotfiles_install_path | path join "online-judge-tools") ~/.config/online-judge-tools

# for file in ~/dotfiles/bin/*; do
#   link $file ~/.local/bin/$(basename $file)
# done
for file in ($dotfiles_install_path | path join "bin" "*") {
    link $file (~/.local/bin/ + ($file | path basename))
}

git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local
