[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

###########
##
## THIS FILE IS FOR INITIALIZATION
##
###########

# Homebrew
export PATH="/usr/local/sbin:$PATH"

# Go
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin
export PATH="$GOPATH:$GOBIN:$PATH"

# Scripts
export PATH="$PATH:$HOME/projects/scripts"

# RVM & Ruby
#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# If terminal emacs runs the init file is causes an error
# TODO: Update for macos ventura and apple chips
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs -nw -Q"
export EDITOR="/Applications/Emacs.app/Contents/MacOS/Emacs -nw -Q"

[ -f "$HOME/.aliases" ] && source "$HOME/.aliases"
[ -f "$HOME/.other_aliases" ] && source "$HOME/.other_aliases"

###########
##
## ZSH Prompt and Functionality
##
###########

autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b'

setopt PROMPT_SUBST
PROMPT='%B%F{magenta}[%F{green}%n %F{red}${PWD/#$HOME/~} %F{cyan}${vcs_info_msg_0_}%F{magenta}]$ %F{white}%b'


# Stop at "/" and "_" when alt+backspacing
backward-kill-dir () {
    local WORDCHARS=${WORDCHARS/\/}
    local WORDCHARS=${WORDCHARS/_}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

autoload -Uz compinit && compinit

# Allow comments in the terminal
setopt interactivecomments
