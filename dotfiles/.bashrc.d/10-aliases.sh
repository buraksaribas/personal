alias ls='ls -Fh --color=auto'
alias ll='ls -lav --ignore=.. --color=auto'
alias la='ls -A'
alias l='ls -l'

alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias ~='cd ~'
alias df='df -hT'
alias free='free -h'
alias cl='clear'

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

# alias update='sudo dnf update -y && flatpak update -y'
alias update='sudo pacman -Syu'

alias pavucontrol='pavucontrol-qt'

