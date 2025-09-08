#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Colorful Prompt
if [ "$TERM" != "dumb" ]; then
  PS1='\[\e[0;35m\]\u\[\e[0;36m\]@\h \[\e[0;32m\]\w \[\e[0;37m\]\$ \[\e[0m\]'
fi

eval "$(mise activate bash)"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion
