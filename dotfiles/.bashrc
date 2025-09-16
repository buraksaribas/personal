#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colorful Prompt
if [ "$TERM" != "dumb" ]; then
  PS1='\[\e[0;35m\]\u\[\e[0;36m\]@\h \[\e[0;32m\]\w \[\e[0;37m\]\$ \[\e[0m\]'
fi

eval "$(mise activate bash)"

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion


HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -u histappend

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"

# ---------- Alias ----------
alias ls='ls --color=auto -h --group-directories-first'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Git
alias gi='git init'
alias gaa='git add .'
alias gcm='git commit -m'
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gl='git log --oneline --graph --decorate'

# Shortcuts
alias v='nvim'
alias pn='pnpm'
alias pna='pnpm add'
alias pnx='pnpm dlx'
alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias untar='tar -xvzf'
alias targz='tar -czvf'
