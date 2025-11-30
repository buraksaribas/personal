# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Catppuccin Macchiato Theme
CTP_ROSEWATER="\[\e[38;2;244;219;214m\]"
CTP_FLAMINGO="\[\e[38;2;240;198;198m\]"
CTP_PINK="\[\e[38;2;245;169;227m\]"
CTP_MAUVE="\[\e[38;2;198;160;246m\]"
CTP_RED="\[\e[38;2;237;135;150m\]"
CTP_MAROON="\[\e[38;2;238;153;160m\]"
CTP_PEACH="\[\e[38;2;245;169;127m\]"
CTP_YELLOW="\[\e[38;2;238;212;159m\]"
CTP_GREEN="\[\e[38;2;166;209;137m\]"
CTP_TEAL="\[\e[38;2;125;196;228m\]"
CTP_SKY="\[\e[38;2;145;215;227m\]"
CTP_SAPPHIRE="\[\e[38;2;125;180;227m\]"
CTP_BLUE="\[\e[38;2;138;173;244m\]"
CTP_LAVENDER="\[\e[38;2;183;189;248m\]"
CTP_TEXT="\[\e[38;2;202;211;245m\]"
CTP_SUBTEXT1="\[\e[38;2;165;173;203m\]"
CTP_SURFACE0="\[\e[38;2;54;58;79m\]"
CTP_SURFACE1="\[\e[38;2;73;77;100m\]"
CTP_SURFACE2="\[\e[38;2;92;95;119m\]"
CTP_RESET="\[\e[0m\]"

### Prompt (PS1)
parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
PS1="${CTP_MAUVE}\u${CTP_SURFACE1}@${CTP_BLUE}\h ${CTP_LAVENDER}\w${CTP_GREEN}\$(parse_git_branch)${CTP_RESET}"
PS1+="\n"
PS1+="\$([[ \$? != 0 ]] && echo \"${CTP_RED}\" || echo \"${CTP_GREEN}\")❯${CTP_RESET} "
export PS1

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

### Aliases
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Git
alias gs='git status -sb'
alias ga='git add .'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -m'
alias gp='git push'
alias gl='git pull --prune'
alias gd='git diff'
alias gdc='git diff --cached'
alias glog="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
alias gundo='git reset --soft HEAD~1'

# System
alias temp='watch -n 1 "sensors"'
alias battery='upower -i $(upower -e | grep BAT)'
alias cpu='lscpu'
alias df='df -h'
alias free='free -h'
alias update='sudo pacman -Syu --noconfirm'
alias ka="killall"
alias cl='clear'
alias img='swayimg'
alias v='nvim'
alias untar='tar -xvzf'
alias targz='tar -czvf'

# Editor
export EDITOR=nvim
export VISUAL=nvim

# History
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Helper
shopt -s autocd
shopt -s checkwinsize
shopt -s expand_aliases

# Bash Completion
[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion

# Catppuccin Macchiato LS_COLORS
export LS_COLORS="di=38;2;138;173;244:fi=38;2;202;211;245:ln=38;2;198;160;246:\
so=38;2;245;169;127:pi=38;2;238;212;159:ex=38;2;125;196;228:\
bd=38;2;238;212;159:cd=38;2;238;212;159:\
su=38;2;237;135;150:ow=38;2;166;209;137:st=38;2;125;196;228:\
tw=38;2;166;209;137:*~=38;2;165;173;203"

eval "$(mise activate bash)"
