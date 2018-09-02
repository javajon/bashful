# Git Bash performance
git config --global core.preloadindex true
git config --global core.fscache true
git config --global gc.auto 256

alias gw='./gradlew'
alias mk='minikube'
alias kc='kubectl'

RESET=$(tput sgr0)
BLUE=$(tput setaf 4)
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
GREEN=$(tput setaf 2)

prompt() {
    # Colorize prompt for status of last command
    if [ $? == 0 ]; 
        then SIGN="$GREEN\$"; 
        else SIGN="$RED\$"; 
    fi

    BRANCH=$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/ (\1) /')
    IN_GIT_REPO="$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "yes"; else echo "no"; fi)"

    if [ $IN_GIT_REPO == "yes" ];
    then
        # Check for uncommitted files
        GIT_STATUS="$(git status | grep "nothing to commit" > /dev/null 2>&1; if [ $? -eq 0 ]; then echo "clean"; else echo "unclean"; fi)"
    
        if [ $GIT_STATUS == "clean" ];
        then
            # No uncommitted files
            GIT_INFO='$GREEN$BRANCH'
        else
            # There are uncommitted files
            GIT_INFO='$RED$BRANCH'
        fi
    else
        # Diplay nothing if not in a Git repo
        GIT_INFO=""
    fi

    PS1="${BLUE}\w$GIT_INFO\n$SIGN $RESET"
}

PROMPT_COMMAND=prompt
cd /c/dev/dijure
