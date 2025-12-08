#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$HOME/personal/dotfiles"

DOTFILES=(
  #.bashrc
  .gitconfig
  #.zshrc
)

BASHRC_D_FILES=(
  00-env.sh
  10-aliases.sh
  20-functions.sh
  30-ls_colors.sh
  50-prompt.sh
  99-others.sh
)

CONFIG_DIRS=(
  dunst
  #foot
  hypr
  #i3status-rust
  kitty
  #mako
  nvim
  #rofi
  #sway
  #swaylock
  #tmux
  waybar
  wofi
)

safe_link() {
  local src="$1"
  local dst="$2"

  [ ! -e "$src" ] && return

  if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
    return
  fi

  if [ -e "$dst" ]; then
    mv "$dst" "${dst}.backup"
  fi

  ln -sf "$src" "$dst"
  echo "Linked: $dst"
}

safe_link_dir() {
  local src="$1"
  local dst="$2"

  [ ! -d "$src" ] && return

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
    return
  fi

  if [ -e "$dst" ]; then
    mv "$dst" "${dst}.backup"
  fi

  ln -sfn "$src" "$dst"
  echo "Linked: $dst"
}

echo "Linking dotfiles..."

if [ -d "$DOTFILES_DIR" ]; then
  for file in "${DOTFILES[@]}"; do
    safe_link "$DOTFILES_DIR/$file" "$HOME/$file"
  done
fi

mkdir -p "$HOME/.bashrc.d"
for rc in "${BASHRC_D_FILES[@]}"; do
  [[ "$rc" =~ ^#.*$ ]] && continue
  safe_link "$DOTFILES_DIR/.bashrc.d/$rc" "$HOME/.bashrc.d/$rc"
done

mkdir -p "$HOME/.config"
for cfg in "${CONFIG_DIRS[@]}"; do
  safe_link_dir "$DOTFILES_DIR/.config/$cfg" "$HOME/.config/$cfg"
done

safe_link_dir "$HOME/personal/fonts" "$HOME/.local/share/fonts"
safe_link_dir "$HOME/personal/themes" "$HOME/.local/share/themes"
safe_link_dir "$HOME/personal/icons" "$HOME/.local/share/icons"

[ -d "$HOME/.local/share/fonts" ] && fc-cache -fv >/dev/null 2>&1

echo "Done!"
