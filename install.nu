#!/usr/bin/env nu
def command_exists [cmd: string] {
  (which $cmd | length) > 0
}
let is_linux = (uname | get kernel-name | str downcase) == "linux"
let is_macos = (uname | get kernel-name | str downcase) == "darwin"
let is_windows = (uname | get kernel-name | str downcase) == "windows_nt"
let is_x86_64 = (uname | get machine) == "x86_64"
let is_aarch64 = (uname | get machine) == "aarch64" or (uname | get machine) == "arm64"
mut requirements  = if $is_linux {
  {
    "git": "git",
    "make": "build-essential",
    "pkg-config": "pkg-config",
    "autoconf": "autoconf",
    "gawk": "gawk",
  }
} else if $is_macos {
  {
    "git": "git",
    "make": "make",
    "pkg-config": "pkg-config",
    "autoconf": "autoconf",
    "gawk": "gawk",
  }
} else {
  {
    "git": "Git.Git"
  }
}
mut missing = []
for $cmd in ($requirements | columns) {
  if not (command_exists $cmd) {
    $missing = $missing ++ [$cmd]
  }
}
if ($missing | length) > 0 {
  print $"Please install the following packages first:"
  for pkg in $missing {
    print $"  - ($requirements | get $pkg) for command ($pkg)"
  }
  if $is_windows {
    print "Run:"
    print -n "  winget install"
    for pkg in $missing {
      print -n $" ($requirements | get $pkg)"
    }
    print ""
  } else if $is_macos {
    print "You can install them using Homebrew:"
    print -n "  brew install"
    for pkg in $missing {
      print -n $" ($requirements | get $pkg)"
    }
    print ""
  } else if $is_linux {
    print "You can install them using your package manager, e.g., on Debian/Ubuntu:"
    print -n "  sudo apt-get install"
    for pkg in $missing {
      print -n $" ($requirements | get $pkg)"
    }
    print ""
  }

  exit 1
}
print "All required commands are available."

if $is_linux {
  let ruby_build_requirements = {
    "openssl": "libssl-dev",
    "yaml-0.1": "libyaml-dev",
    "zlib": "zlib1g-dev",
    "libffi": "libffi-dev",
    "gmp": "libgmp-dev",
  }

  mut missing_ruby_build = []
  for $pkg in ($ruby_build_requirements | columns) {
    if (try {
      pkg-config --exists $pkg
      false
    } catch {
      true
    }) {
      $missing_ruby_build = $missing_ruby_build ++ [($ruby_build_requirements | get $pkg)]
    }
  }
  if ($missing_ruby_build | length) > 0 {
    print $"Please install the following packages for ruby-build first:"
    for pkg in $missing_ruby_build {
      print $"  - ($pkg)"
    }
    print "On Debian/Ubuntu, you can run:"
    print -n "  sudo apt-get install"
    for pkg in $missing_ruby_build {
      print -n $" ($pkg)"
    }
    exit 1
  }
} else if $is_macos {
  let ruby_build_requirements = [
    "openssl@3",
    "readline",
    "libyaml",
    "gmp",
    "autoconf"
  ]
  mut missing_ruby_build = []
  for pkg in $ruby_build_requirements {
    if (try {
      brew list $pkg
      false
    } catch {
      true
    }) {
      $missing_ruby_build = $missing_ruby_build ++ [$pkg]
    }
  }
  if ($missing_ruby_build | length) > 0 {
    print $"Please install the following Homebrew packages for ruby-build first:"
    for pkg in $missing_ruby_build {
      print $"  - ($pkg)"
    }
    print "You can run:"
    print -n "  brew install"
    for pkg in $missing_ruby_build {
      print -n $" ($pkg)"
    }
    print ""
    exit 1
  }
}

let dotfiles_install_path = ($env.DOTFILES_INSTALL_PATH? | default "~/dotfiles") | path expand
if ($dotfiles_install_path | path exists) {
  print $"Dotfiles installation path ($dotfiles_install_path) already exists."

  git -C $dotfiles_install_path pull
} else {
  print $"Cloning dotfiles to ($dotfiles_install_path)"

  git clone https://github.com/sevenc-nanashi/dotfiles $dotfiles_install_path
}

cd $dotfiles_install_path

def download [url: string, dest?: string] {
  if $dest == null {
    try {
      http -r $url
    } catch {
      curl -sSL $url
    }
  } else {
    let dest_path = ($dest | path expand)
    if not ($dest_path | path dirname | path exists) {
      mkdir ($dest_path | path dirname)
    }
    try {
      http $url o> $dest_path
    } catch {
      curl -sSL $url -o $dest_path
    }
  }
}

if not (command_exists "rustup") {
  print "Installing rustup"
  download https://sh.rustup.rs | sh -s -- -y
  if $is_windows {
    $env.PATH = ($env.PATH | prepend $"($env.USERPROFILE)\\.cargo\\bin")
  } else {
    $env.PATH = ($env.PATH | prepend $"($env.HOME)/.cargo/bin")
  }
}

if not (command_exists "nvim") {
  print "Installing nightly nvim"
  let nvim_bin = ("~/.local/bin/nvim" | path expand)
  if $is_linux {
    let nvim_variant = if $is_x86_64 {
      "linux-x86_64"
    } else if $is_aarch64 {
      "linux-aarch64"
    } else {
      print "Unsupported architecture for nvim nightly"
      exit 1
    }
    download $"https://github.com/neovim/neovim/releases/download/nightly/nvim-($nvim_variant).appimage" $nvim_bin
    chmod +x $nvim_bin
  } else if $is_macos {
    let nvim_variant = if $is_x86_64 {
      "macos-x86_64"
    } else if $is_aarch64 {
      "macos-arm64"
    } else {
      print "Unsupported architecture for nvim nightly"
      exit 1
    }
    download $"https://github.com/neovim/neovim/releases/download/nightly/nvim-($nvim_variant).tar.gz" /tmp/nvim.tar.gz
    let nvim_install_dir = ($env.NVIM_INSTALL_DIR? | default "~/nvim-nightly") | path expand
    tar -xzf /tmp/nvim.tar.gz -C /tmp
    mkdir $nvim_install_dir
    mv $"/tmp/nvim-(nvim_variant)"/* $nvim_install_dir
    if not ($nvim_bin | path dirname | path exists) {
      mkdir ($nvim_bin | path dirname)
    }
    ln -s ($nvim_install_dir | path join "bin" "nvim") $nvim_bin
  } else if $is_windows {
    print "Nightly nvim is available here:"
    print "https://github.com/neovim/neovim/releases/nightly"
  } else {
    print "Unsupported host for nvim nightly"
  }
}

print "Installing vim-jetpack"
let jetpack_path = if $is_windows {
  $"($env.LOCALAPPDATA)\\nvim-data\\site\\pack\\jetpack\\opt\\vim-jetpack\\plugin\\jetpack.vim"
} else {
  "~/.local/share/nvim/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim"
}
download https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim $jetpack_path

# Needs sudo
# TODO: better way to handle Homebrew installation
# print "Installing Homebrew"
# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash

print "Creating symbolic links for configuration files"
def link [src: string, dest: string] {
  let src_path = ($src | path expand -n)
  let dest_path = ($dest | path expand -n)
  let dest_realpath = (try {
    $dest_path | path expand
  } catch {
    ""
  })
  if $dest_realpath == $src_path {
    print $"($dest_path) already symlinked, skipping"
    return
  }
  if ($dest_path | path exists) {
    print $"Backing up existing file ($dest_path) to ($dest_path).bak"
    mv $dest_path $"($dest_path).bak"
  }
  print $"Linking ($src_path) to ($dest_path)"
  if not ($dest_path | path dirname | path exists) {
    mkdir ($dest_path | path dirname)
  }
  ln -s $src_path $dest_path
}

link ($dotfiles_install_path | path join ".bashrc") ~/.bashrc
link ($dotfiles_install_path | path join "neovim") ~/.config/nvim
link ($dotfiles_install_path | path join ".irbrc") ~/.irbrc
link ($dotfiles_install_path | path join global_agents.md) ~/.codex/AGENTS.md
link ($dotfiles_install_path | path join ".gitconfig") ~/.gitconfig
link ($dotfiles_install_path | path join ".gitignore_global") ~/.gitignore_global
link ($dotfiles_install_path | path join "starship.toml") ~/.config/starship.toml
link ($dotfiles_install_path | path join "bat.config") ~/.config/bat/config
link ($dotfiles_install_path | path join "gh.config.yml") ~/.config/gh/config.yml
link ($dotfiles_install_path | path join "mise") ~/.config/mise
link ($dotfiles_install_path | path join "nushell") ~/.config/nushell
link ($dotfiles_install_path | path join "online-judge-tools") ~/.config/online-judge-tools

print "Installing tools managed by mise"
let mise_bin_dir = ($env.MISE_PATH | path dirname)
if ($mise_bin_dir | path exists) {
  $env.PATH = ($env.PATH | prepend $mise_bin_dir)
}
let mise_shims_dir = ("~/.local/share/mise/shims" | path expand)
$env.PATH = ($env.PATH | prepend $mise_shims_dir)
^($env.MISE_PATH) trust .
^($env.MISE_PATH) settings experimental=true  # Why not?
^($env.MISE_PATH) settings lockfile=true
^($env.MISE_PATH) install
if (which yarn | length) == 0 {
  print "Installing yarn for Neovim plugin builds"
  ^($env.MISE_PATH) install "npm:yarn@latest"
}

print "Install neovim plugins"
if $is_linux {
  $env.APPIMAGE_EXTRACT_AND_RUN = "1"
}
nvim --headless +JetpackSync +qall

print "Creating symbolic links for custom binaries"
let local_bin_dir = ("~/.local/bin" | path expand)
let bin_dir = ($dotfiles_install_path | path join "bin")
for file in (ls $bin_dir | get name) {
  link $file ($local_bin_dir | path join ($file | path basename))
}

if ($is_linux or $is_macos) {
  print "Installing ble.sh"
  git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
  let local_prefix = ("~/.local" | path expand)
  make -C ble.sh install $"PREFIX=($local_prefix)"
}

print "Setting up git remote to use SSH"
git -C $dotfiles_install_path remote set-url origin git@github.com:sevenc-nanashi/dotfiles.git
print "Adding SSH keys from GitHub"
let ssh_dir = ("~/.ssh" | path expand)
if not ($ssh_dir | path exists) {
  mkdir $ssh_dir
}
download https://github.com/sevenc-nanashi.keys o>> ($ssh_dir | path join "authorized_keys")

echo "Installation complete!"
download https://sevenc7c.com
