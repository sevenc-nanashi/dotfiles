$env.CARAPACE_BRIDGES = "zsh,fish,bash,inshellisense"
def install_autoload [] {
    mkdir ($nu.data-dir | path join "vendor/autoload")
    mise activate nu | save ($nu.data-dir | path join "vendor/autoload" "mise.nu") -f
    mise x starship -- starship init nu | save ($nu.data-dir | path join "vendor/autoload" "starship.nu") -f

    mise x github:carapace-sh/carapace-bin -- carapace _carapace nushell | save ($nu.data-dir | path join "vendor/autoload" "carapace.nu") -f
}

if not (($nu.data-dir | path join "vendor/autoload" "starship.nu") | path exists) {
    install_autoload
}
