autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '(%b)'
precmd() {
  vcs_info

  # Get the full path of the current directory
  local cwd="$PWD"
  local last_dir="${cwd##*/}"

  # Count slashes to determine if it’s deep
  local slash_count=${cwd//[^\/]/}
  local num_slashes=${#slash_count}

  # Determine if we're in the home directory
	if [[ "$cwd" == "$HOME" ]]; then
		PROMPT='%F{224}two-x@%m%f:%F{111}~%f %F{#f9e2af}${vcs_info_msg_0_}%f$ '
		elif (( num_slashes > 1 )); then
			PROMPT='%F{224}two-x@%m%f:%F{111}/…/'"${last_dir}"'%f %F{#f9e2af}${vcs_info_msg_0_}%f$ '
			else
				PROMPT='%F{224}two-x@%m%f:%F{111}%~%f %F{#f9e2af}${vcs_info_msg_0_}%f$ '
	fi
}
setopt prompt_subst

# export LSCOLORS="gxfxcxdxcxegedabagacad"
export LSCOLORS="gxfxcxdxbxGxEdabagacad"

# colors for ls commands
alias ls='ls -G'

alias edit-rc='nvim ~/.zshrc'
alias source-rc='source ~/.zshrc'
alias slack='open -a "Slack"'
alias chrome='open -a "Google Chrome"'
alias outlook='open -a "Microsoft Outlook"'
alias teams='open -a "Microsoft Teams"'
alias safari='open -a "Safari"'
alias webstorm='open -a "WebStorm"'
alias phpstorm='open -a "PhpStorm"'
alias intellij='open -a "IntelliJ IDEA Ultimate"'
alias goland='open -a "GoLand"'
alias request-rocket='open -a "Request Rocket"'
alias docker-desktop='open -a "Docker Desktop"'
alias gcp-sql='google-cloud-sql'
alias gcp-sql-show='google-cloud-sql configurations show'
alias gcp-sql-run='google-cloud-sql configurations run'
alias pycharm='open -a "PyCharm"'

tmux-code() {
    # Check if we're already in a tmux session
    if [ -n "$TMUX" ]; then
        echo "Already in a tmux session. Please run this function outside of tmux."
        return 1
    fi

    # Start a new tmux session
    tmux new-session -d -s code

    # Create and set up the nvim window
    tmux rename-window -t code:0 nvim
    tmux split-window -t code:0 -h -p 30
		tmux send-keys -t code:0.0 "clear" C-m
    tmux send-keys -t code:0.0 "nvim ." C-m

    # Create the shell window
    tmux new-window -t code:1 -n shell
    tmux send-keys -t code:1 "clear" C-m

    # Select the nvim window and the top pane
    tmux select-window -t code:0
    tmux select-pane -t code:0.0

		tmux attach-session -t code
}


tmux-shell() {
    # Check if we're already in a tmux session
    if [ -n "$TMUX" ]; then
        echo "Already in a tmux session. Please run this function outside of tmux."
        return 1
    fi

    # Start a new tmux session
    tmux new-session -d -s code

    # Create and set up the nvim window
    tmux rename-window -t code:0 client
    tmux send-keys -t code:0 "clear" C-m

    # Create the shell2 window
    tmux new-window -t code:1 -n service
    tmux send-keys -t code:1 "clear" C-m

    # Create the shell3 window
    tmux new-window -t code:2 -n dataflow
    tmux send-keys -t code:2 "clear" C-m

    # Create the shell3 window
    tmux new-window -t code:3 -n notes
    tmux send-keys -t code:3 "clear" C-m

    # Select the window
    tmux select-window -t code:0

		tmux attach-session -t code
}

export PATH="$HOME/go/bin:$PATH"
