#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gw='./gradlew'

# Git Bash performance
git config --global core.preloadindex true
git config --global core.fscache true
git config --global gc.auto 256

<<<<<<< HEAD
# Kubernetes
alias mk='minikube'
alias kc='kubectl'
=======
alias gw='./gradlew $@'
alias mk='minikube $@'
alias kc='kubectl $@'
>>>>>>> 402bfb1320118470aaa2b79e5616ef3132896203

# Completions 
# (some are routed to scratch file due to missing /dev/fd on git bash Windows)
source $HOME/bash_completion.bash
source $HOME/.kube/kubectl_autocompletion
kubectl completion bash > completion-scratch.txt
source completion-scratch.txt
helm completion bash > completion-scratch.txt
source completion-scratch.txt
minikube completion bash > completion-scratch.txt
source completion-scratch.txt
eval "$(minikube docker-env --shell bash)"

calculate_prompt_elements() {
    # Colorize prompt for status of last command, do this first to preserve status
    PRM_STATUS=$?

    BRANCH=$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1) /')
    IN_GIT_REPO="$(git branch &>/dev/null; if [ $? -eq 0 ]; then printf "yes"; else printf "no"; fi)"

    if [ "$IN_GIT_REPO" == "yes" ];
    then
        # Check for uncommitted files
        GIT_STATUS="$(git status | grep "nothing to commit" > /dev/null 2>&1; if [ $? -eq 0 ]; then printf "clean"; else printf "unclean"; fi)"
    
        if [ "$GIT_STATUS" == "clean" ];
        then
            # No uncommitted files
            GIT_INFO=1
        else
            # There are uncommitted files
            GIT_INFO=2
        fi
    else
        # Display nothing if not in a Git repo
        GIT_INFO=0
    fi
}

bash_prompt() {
    RESET=$(tput sgr0)
    BLUE=$(tput setaf 4)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    YELLOW=$(tput setaf 3)
    GREEN=$(tput setaf 2)

    BRANCH_COLOR='$(if [[ $GIT_INFO == 1 ]]; then printf %s $GREEN; elif [[ $GIT_INFO == 2 ]]; then printf %s $RED; else printf %s $YELLOW; fi)$BRANCH'
    PROMPT_COLOR='$(if [[ $PRM_STATUS == 0 ]]; then printf %s $GREEN; else printf %s $RED; fi)'
    
    PS1="\[$BLUE\]\[\w\]"
    PS1+="\[$BRANCH_COLOR\]"
    PS1+="\[\012\]"
    PS1+="\[$PROMPT_COLOR\]\[\$\] "
    PS1+="\[$RESET\]"
}

PROMPT_COMMAND=calculate_prompt_elements
bash_prompt
unset bash_prompt
cd /c/dev/dijure
