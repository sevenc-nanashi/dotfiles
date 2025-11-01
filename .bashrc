if [ -z "$DEMO" ]; then
	### Added by Codeium. These lines cannot be automatically removed if modified
	if command -v termium > /dev/null 2>&1; then
		eval "$(termium shell-hook show pre)"
	fi
fi
### End of Codeium integration
#
#

if [ -f ~/.bashrc.local ]; then
	source ~/.bashrc.local
fi


eval "$($HOME/.local/bin/mise activate bash)"
export PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH"
export PATH="$(aqua root-dir)/bin:$PATH"
export AQUA_GLOBAL_CONFIG="$HOME/.config/aqua.yaml"

if [[ $(type -t LANG_SETUP_LOADED) != function ]]; then
    function LANG_SETUP_LOADED() {
        echo "LANG_SETUP_LOADED"
    }
    alias envcache="$HOME/.cargo/bin/envcache"
    export PATH=$(/usr/bin/printenv PATH | /usr/bin/perl -ne 'print join(":", grep { !/\/mnt\/[a-z]/ } split(/:/));')

    . "$HOME/.cargo/env"

    [ "$STARSHIP_DISABLE" = "true" ] || eval "$(starship init bash)"

    . "$HOME/.deno/env"
    export PATH="$DENO_INSTALL/bin:$PATH"
    eval "$(deno completions bash)"

    export GOPATH=$HOME/go
    export GOBIN=$GOPATH/bin
    export PATH=$PATH:$GOBIN

    source ~/.local/share/blesh/ble.sh

    export PATH=$PATH:$HOME/.local/bin
    export PATH=$PATH:$HOME/.local/opt/gradle/bin

    # bun
    export BUN_INSTALL="$HOME/.bun"
    export PATH=$BUN_INSTALL/bin:$PATH

    for bcfile in ~/.bash_completion.d/* ; do
      . $bcfile
    done

    eval "$(envcache pnpm completion bash)"
    eval "$(envcache npm completion)"
    # eval "$(envcache nr --completion)"

    export PATH="$HOME/.local/share/cmvm/current/bin:$PATH"
    # EMSDK_QUIET=1 source "$HOME/emsdk/emsdk_env.sh"

    # setxkbmap -model jp109 -layout jp

    alias py='python3'
    alias rb='ruby'

    alias gh="env -u GITHUB_TOKEN env -u GH_TOKEN gh"
    # eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

    [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

    if [[ -s "$HOME/.crenv/bin/crenv" ]]; then
      export PATH="$HOME/.crenv/bin:$PATH"
      eval "$(crenv init -)"
    fi

    if [[ -s "$HOME/emsdk" ]]; then
      EMSDK_QUIET=1 source "$HOME/emsdk/emsdk_env.sh"
    fi

    # Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
    export PATH="$PATH:$HOME/.rvm/bin"
    source $HOME/.rvm/scripts/rvm
fi

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
	xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
	xterm*|rxvt*)
		PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
		;;
	*)
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ls="eza"
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias cat="bat"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

    if type -t ble-face >/dev/null; then
      ble-face argument_error=fg=red,bg=225
      ble-face argument_option=fg=teal
      ble-face auto_complete=fg=8
      ble-face cmdinfo_cd_cdpath=fg=26,bg=155
      ble-face command_alias=fg=teal
      ble-face command_builtin=fg=red
      ble-face command_builtin_dot=fg=red,bold
      ble-face command_directory=fg=26,underline
      ble-face command_file=fg=green
      ble-face command_function=fg=purple
      ble-face command_jobs=fg=red,bold
      ble-face command_keyword=fg=blue
      ble-face disabled=fg=8
      ble-face filename_block=fg=yellow,bg=black,underline
      ble-face filename_character=fg=white,bg=black,underline
      ble-face filename_directory=fg=blue,underline
      ble-face filename_directory_sticky=fg=white,bg=blue,underline
      ble-face filename_executable=fg=green,underline
      ble-face filename_link=fg=teal,underline
      ble-face filename_ls_colors=underline
      ble-face filename_orphan=fg=teal,bg=224,underline
      ble-face filename_other=underline
      ble-face filename_pipe=fg=lime,bg=black,underline
      ble-face filename_setgid=fg=black,bg=191,underline
      ble-face filename_setuid=fg=black,bg=220,underline
      ble-face filename_socket=fg=cyan,bg=black,underline
      ble-face filename_url=fg=blue,underline
      ble-face filename_warning=fg=red,underline
      ble-face overwrite_mode=fg=black,bg=51
      ble-face prompt_status_line=fg=231,bg=240
      ble-face region=fg=white,bg=60
      ble-face region_insert=fg=blue,bg=252
      ble-face region_match=fg=white,bg=55
      ble-face region_target=fg=black,bg=153
      ble-face syntax_brace=fg=37,bold
      ble-face syntax_command=fg=brown
      ble-face syntax_comment=fg=242
      ble-face syntax_default=none
      ble-face syntax_delimiter=bold
      ble-face syntax_document=fg=94
      ble-face syntax_document_begin=fg=94,bold
      ble-face syntax_error=fg=231,bg=203
      ble-face syntax_escape=fg=magenta
      ble-face syntax_expr=fg=26
      ble-face syntax_function_name=fg=92,bold
      ble-face syntax_glob=fg=198,bold
      ble-face syntax_history_expansion=fg=231,bg=94
      ble-face syntax_param_expansion=fg=purple
      ble-face syntax_quotation=fg=green,bold
      ble-face syntax_quoted=fg=green
      ble-face syntax_tilde=fg=navy,bold
      ble-face syntax_varname=fg=orange
      ble-face varname_array=fg=orange,bold
      ble-face varname_empty=fg=31
      ble-face varname_export=fg=200,bold
      ble-face varname_expr=fg=92,bold
      ble-face varname_hash=fg=70,bold
      ble-face varname_number=fg=64
      ble-face varname_readonly=fg=200
      ble-face varname_transform=fg=29,bold
      ble-face varname_unset=fg=124
      ble-face vbell=reverse
      ble-face vbell_erase=bg=252
      ble-face vbell_flash=fg=green,reverse
    fi

function neovide() {
	/mnt/c/windows/system32/cmd.exe /C start "neovide" --wsl -- --cmd "cd $(pwd)" $@
}

alias sapt='sudo apt -y'
alias explorer='/mnt/c/Windows/explorer.exe .'

function expose() {
	timeout 0.1 nc -z "$(hostname).local" 10601
	if [ $? -ne 0 ]; then
		echo "netsh-server is not running"
		return 1
	fi
	PORT=$1
	if [ -z "$PORT" ]; then
		curl "http://$(hostname).local:10601/ports"
	elif [ "$PORT" = "exit" ]; then
		curl "http://$(hostname).local:10601/exit"
	else
		curl -XPOST "http://$(hostname).local:10601/ports?port=$PORT"
	fi
	echo ""
}

function rex() {
	if [ -f "$1" ]; then
		bundle exec ruby "$@"
	else
		bundle exec $@
	fi
	return $?
}

function cab() {
	echo "Co-Authored-By: $1 <$1@users.noreply.github.com>"
}

function rgsed() {
	rg -l "$1" | xargs sed -i "s/$1/$2/g"
}

set -o vi

PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;

export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

if [ -z "$DEMO" ]; then
	### Added by Codeium. These lines cannot be automatically removed if modified
	if command -v termium > /dev/null 2>&1; then
		eval "$(termium shell-hook show post)"
	fi
	### End of Codeium integration
fi
source $HOME/.local/share/bash-completion/completions/deno.bash
for f in $HOME/.bash_completion.d/*.bash; do
  source $f
done

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
	*":$PNPM_HOME:"*) ;;
	*) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
###-end-nr-completion-###
