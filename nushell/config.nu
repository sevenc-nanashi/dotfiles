# config.nu
#
# Installed by:
# version = "0.108.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# Nushell sets "sensible defaults" for most configuration settings, 
# so your `config.nu` only needs to override these defaults if desired.
#
# You can open this file in your default editor using:
#     config nu
#
# You can also pretty-print and page through the documentation for configuration
# options using:
#     config nu --doc | nu-highlight | less -R

alias cat = bat
alias ll = ls -al

$env.config.table.mode = 'rounded'
use std/config light-theme
$env.config = {
  color_config: (light-theme)
}

$env.config.color_config = {
    header: "cyan"
    separator: "blue"
    bool: "yellow"
    int: "green"
    float: "green"
    string: "black"
    date: "magenta"
    duration: "red"
    range: "yellow"
    file: "cyan"
    dir: "blue"
    block: "black"
    list: "black"
    record: "black"
}

def rex [...args] {
    if ($args.0 | path type) == "file" {
        bundle exec ruby ...$args
    } else {
        bundle exec ...$args
    }
}

$env.config.edit_mode = 'vi'
$env.config.keybindings ++= [{
    name: ctrl_c_as_esc
    mode: vi_insert
    modifier: control
    keycode: char_c
    event: [{ send: ViChangeMode mode: normal }]
}]

alias mr = mise run
alias gti = git

# use ($nu.default-config-dir | path join mise.nu)
