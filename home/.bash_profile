#
# ~/.bash_profile
#

if [ -f ${HOME}/.bashrc ]; then
    . ${HOME}/.bashrc
fi

[[ ! $DISPLAY && $XDG_VTNR -eq 1 && $(id --group) -ne 0 ]] && exec startx
