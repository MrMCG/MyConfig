#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#--------------------
# Alias
#--------------------

alias ls="ls --color=always"
alias ll="ls -l"
alias la="ls -la"

alias grep="grep --color=auto --line-number"
alias grep-near="grep -A 3 -B 3"

alias logs="find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/:$//g' | grep -v '[0-9]$' | xargs tail -f"

alias folders=$(find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn)
alias diskspace="du -S | sort -n -r |more"

alias vimall="vim * \.*"

#--------------------
# Exports
#--------------------

export HISTFILESIZE=20000
export HISTSIZE=10000

# Coloured man pages in less
export LESS_TERMCAP_mb=$"\E[01;31m"
export LESS_TERMCAP_md=$"\E[01;31m"
export LESS_TERMCAP_me=$"\E[0m"
export LESS_TERMCAP_se=$"\E[0m"
export LESS_TERMCAP_so=$"\E[01;44;33m"
export LESS_TERMCAP_ue=$"\E[0m"
export LESS_TERMCAP_us=$"\E[01;32m"

#--------------------
# Options
#--------------------

set -o vi

stty -ixon

#--------------------
# Functions
#--------------------

up() { 
    cd $(eval printf '../'%.0s {1..$1}) && pwd; 
}

extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf   $1  ;;
            *.tar.gz)    tar xvzf   $1  ;;
            *.bz2)       bunzip2    $1  ;;
            *.rar)       unrar x    $1  ;;
            *.gz)        gunzip     $1  ;;
            *.tar)       tar xvf    $1  ;;
            *.tbz2)      tar xvjf   $1  ;;
            *.tgz)       tar xvzf   $1  ;;
            *.zip)       unzip      $1  ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x       $1  ;;
            *)           echo "don't know how to extract '$1'..." ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

fawk() {
    local first="awk '{print "
    local last="}'"
    local cmd="${first}\$${1}${last}"
    eval $cmd
}

#--------------------
# PS1
#--------------------

export PS1="[\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;155m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[\033[38;5;75m\]\h\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;15m\] \W ]\\$ \[$(tput sgr0)\]"


#--------------------
# System
#--------------------

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

