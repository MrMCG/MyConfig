#
# ~/.bash_profile
#

if [ -f ${HOME}/.bashrc ]; then
    . ${HOME}/.bashrc
fi

if [[ $- != *i* ]]; then
    
    ## make command history append immediately 
    shopt -s histappend
    PROMPT_COMMAND="history -a;${PROMPT_COMMAND}"

    shopt cdspell dirspell checkwinsize cmdhist direxpand histappend histverify


fi

ulimit -c unlimited

[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
