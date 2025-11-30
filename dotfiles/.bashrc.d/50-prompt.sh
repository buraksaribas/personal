# Catppuccin Macchiato
CTP_MAUVE="\[\e[38;2;198;160;246m\]"
CTP_BLUE="\[\e[38;2;138;173;244m\]"
CTP_LAVENDER="\[\e[38;2;183;189;248m\]"
CTP_GREEN="\[\e[38;2;166;209;137m\]"
CTP_RED="\[\e[38;2;237;135;150m\]"
CTP_SURFACE1="\[\e[38;2;73;77;100m\]"
CTP_RESET="\[\e[0m\]"

parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="${CTP_MAUVE}\u${CTP_SURFACE1}@${CTP_BLUE}\h ${CTP_LAVENDER}\w${CTP_GREEN}\$(parse_git_branch)${CTP_RESET}\n"
PS1+="\$([[ \$? != 0 ]] && echo \"${CTP_RED}\" || echo \"${CTP_GREEN}\")❯${CTP_RESET} "
export PS1
