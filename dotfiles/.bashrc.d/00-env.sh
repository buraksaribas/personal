export EDITOR=nvim
export VISUAL=nvim

export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

shopt -s autocd checkwinsize
bind "set completion-ignore-case on"
