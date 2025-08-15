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
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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

# --- NEW PROMPT STYLE (matches zsh style) ---
__GOLD='\[\e[38;5;224m\]'
__CYAN='\[\e[38;5;111m\]'
__PEACH='\[\e[38;2;249;226;175m\]'
__RESET='\[\e[0m\]'

__bash_path_segment() {
  local cwd="$PWD"
  if [[ "$cwd" == "$HOME" ]]; then
    printf "~"
  else
    local slash_field="${cwd//[^\/]/}"
    local num_slashes=${#slash_field}
    if (( num_slashes > 1 )); then
      printf "/…/%s" "${cwd##*/}"
    else
      printf "%s" "${cwd/#$HOME/~}"
    fi
  fi
}

if [ "$color_prompt" = yes ]; then
    PS1="${__GOLD}two-x@\h${__RESET}:${__CYAN}\$(__bash_path_segment)${__RESET}${__PEACH}\$(parse_git_branch)${__RESET}\$ "
else
    PS1="${__GOLD}two-x@\h${__RESET}:${__CYAN}\$(__bash_path_segment)${__RESET}${__PEACH}\$(parse_git_branch)${__RESET}\$ "
fi
unset color_prompt force_color_prompt
# --- END NEW PROMPT STYLE ---

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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export NVIM_CONFIG="$HOME/.config/nvim"

#my aliases
alias notepad=notepad.exe
alias node=node.exe
alias create-t3-app='npm create t3-app@latest'
alias edit-rc='nvim ~/.bashrc'
alias source-rc='source ~/.bashrc'

#functions
chrome() {
	CHROME_PATH="/mnt/c/Program Files/Google/Chrome/Application/chrome.exe"
	if [ $# -eq 0 ]; then
		"$CHROME_PATH"
	else
		local filepath
		filepath=$(realpath "$1")
		local distro=$(wsl.exe -l --quiet | head -n1 | tr -d '\r')
		local wsl_url="file://wsl.localhost/$distro$filepath"
		"$CHROME_PATH" "$wsl_url"
	fi
}

function class-dir {
	cd ~/;
	cd ..;
	cd ..;
	cd mnt/c/Users/lopezmo/OneDrive\ -\ Rose-Hulman\ Institute\ of\ Technology/Desktop/Desktop\ Misc/obsidian-vaults/two-x-vault/class-quarters/winter-24-25
}

function vault-dir {
	cd ~/;
	cd ..;
	cd ..;
	cd mnt/c/Users/lopezmo/OneDrive\ -\ Rose-Hulman\ Institute\ of\ Technology/Desktop/Desktop\ Misc/obsidian-vaults/two-x-vault/
}

function reset-cursor {
    echo -e "\e[6 q"
    echo -e "\e[?12h"
}

function tmux-code {
	tmux new-session -d -s code
	tmux rename-window -t code.0 "nvim"
	tmux split-window -h -t code
	tmux resize-pane -t code.1 -x "$(($(tmux display -p -F '#{window_width}') * 15 / 100))"
	tmux send-keys -t code:nvim 'spath && clear' C-m
	tmux new-window -t code -n config
	tmux send-keys -t code:config 'cd $NVIM_CONFIG' C-m
	tmux send-keys -t code:config 'nvim .' C-m
	tmux new-window -t code -n btop
	tmux send-keys -t code:btop 'btop' C-m
	tmux select-window -t code:0
	tmux select-pane -t code.0
	tmux send-keys -t code:nvim 'reset-cursor' C-m
	tmux send-keys -t code:nvim 'clear' C-m
	tmux send-keys -t code:nvim 'nvim .' C-m
	tmux attach-session -t code
}

function msim {
	if [ $# -eq 0 ]; then
		modelsim.exe "$1"
	else
		modelsim.exe
	fi
}

function jlab {
	jupyter lab --no-browser --port=8888
}

# --- UPDATED spath / lpath to override prompt ---
spath() {
  local CYAN='\[\e[38;5;111m\]'
  local PEACH='\[\e[38;2;249;226;175m\]'
  local RESET='\[\e[0m\]'
  PS1="${CYAN}\w${RESET}${PEACH}\$(parse_git_branch)${RESET}\$ "
}

lpath() {
  # colors
  local GOLD='\[\e[38;5;224m\]'
  local CYAN='\[\e[38;5;111m\]'
  local PEACH='\[\e[38;2;249;226;175m\]'
  local RESET='\[\e[0m\]'

  # same path logic as your default
  local cwd="$PWD"
  local slash_field="${cwd//[^\/]/}"
  local num_slashes=${#slash_field}
  local PATH_PART
  if [[ "$cwd" == "$HOME" ]]; then
    PATH_PART="~"
  elif (( num_slashes > 1 )); then
    PATH_PART="/…/${cwd##*/}"
  else
    PATH_PART="\w"
  fi

  # use custom username "two-x" and gold color
  PS1="${GOLD}two-x@\h${RESET}:${CYAN}${PATH_PART}${RESET}${PEACH}\$(parse_git_branch)${RESET}\$ "
}
# --- END spath / lpath ---

spawn-ps() {
	powershell.exe -NoExit -Command "cd \"$(wslpath -w "$PWD")\""
}

git-add-unity() {
	git add Assets/* Packages/* ProjectSettings/*
}

jplab() {
	jupyter lab --no-browser
}

export MYVIMRC=~/.config/vim/.vimrc

export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/go/bin:$PATH"   # <-- added here

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PROMPT_DIRTRIM=1

. "$HOME/.cargo/env"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/development/flutter/bin:$PATH"

