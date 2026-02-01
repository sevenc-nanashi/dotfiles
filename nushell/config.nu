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

def ghq_list [] {
    ghq list | split row "\n"
}
def --env gcd [repo?: string@ghq_list] {
  let real_repo = if ($repo == null) {
    ghq list | fzf
  } else {
    $repo
  }
  cd $"(git config ghq.root)/($real_repo)"
}

def --env ridk [...args] {
    let subcmd = ($args | get 0 -o | default "")

    match $subcmd {
        "enable" | "disable" => {
            let out = (ridk.cmd ...$args)
            $out
            | lines
            | parse "{key}={value}"
            | each {|key_value| { ($key_value.key): $key_value.value } }
            | into record
            | load-env
        }

        "exec" => {
            let env_lines = (
                ridk.cmd ($args | get 1)
            )

            $env_lines
            | lines
            | where ($it | str contains "=")
            | parse "{key}={value}"
            | each {|key_value| { ($key_value.key): $key_value.value } }
            | into record
            | load-env

            let rest = ($args | skip 2)
            if ($rest | is-empty) {
                return
            }

            ridk.cmd ...$rest
        }

        "use" => {
            ridk.cmd ...($args | skip 1)
        }

        _ => {
            ridk.cmd ...$args
        }
    }
}


# use ($nu.default-config-dir | path join mise.nu)
