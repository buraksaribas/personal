#!/usr/bin/env bash
set -euo pipefail

echo "=================================================="
echo "    Fresh Arch Setup (archinstall)"
echo "=================================================="

# 1. Full system update
echo "Updating system..."
sudo pacman -Syu --noconfirm

# 2. Install packages
echo "Installing packages..."
sudo pacman -S --noconfirm --needed \
  base base-devel bash-completion \
  dnsmasq dosfstools docker fastfetch fd file-roller \
  firefox fuse3 fzf gimp git go grim htop \
  inkscape lazygit libnotify libpulse libvirt \
  man-db mtools nano neovim \
  ntfs-3g openbsd-netcat os-prober \
  qemu-full ripgrep rustup \
  speech-dispatcher thunar thunar-archive-plugin \
  tlp tlp-rdw ttf-iosevka-nerd ufw unrar unzip vde2 vim virt-manager \
  virt-viewer vlc vlc-plugin-ffmpeg wget \
  wl-clipboard wlsunset \
  zip \
  bridge-utils

# 3. Install paru (AUR helper)
echo "Installing paru..."
if ! command -v paru &>/dev/null; then
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd -
  rm -rf /tmp/paru
fi

# 4. Install brave-bin from AUR
echo "Installing brave-bin..."
paru -S --noconfirm --needed brave-bin

# 5. Enable services
echo "Enabling services..."
sudo systemctl enable --now tlp ufw docker.service
sudo ufw enable
sudo usermod -aG docker,libvirt "$USER"

# 6. Link your dotfiles
DOTFILES_DIR="$HOME/personal/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Warning: Dotfiles not found at $DOTFILES_DIR"
  echo "Please clone your repo first."
else
  echo "Linking dotfiles..."
  mkdir -p ~/.config

  # Home files
  for f in .bashrc .gitconfig; do
    [ -f "$DOTFILES_DIR/$f" ] && ln -sf "$DOTFILES_DIR/$f" "$HOME/$f" && echo "   $f linked"
  done

  # Config folders
  for cfg in foot i3status-rust mako nvim sway swaylock wofi gtk-3.0 gtk-4.0; do
    src="$DOTFILES_DIR/.config/$cfg"
    dst="$HOME/.config/$cfg"
    if [ -d "$src" ]; then
      rm -rf "$dst"
      ln -sf "$src" "$dst"
      echo "   .config/$cfg linked"
    fi
  done
fi

# 7. Link fonts and icons
if [ -d "$HOME/personal/fonts" ]; then
  mkdir -p ~/.local/share
  rm -rf ~/.local/share/fonts
  ln -sf "$HOME/personal/fonts" ~/.local/share/fonts
  fc-cache -fv
  echo "Fonts linked and cache refreshed"
fi

if [ -d "$HOME/personal/themes" ]; then
  rm -rf ~/.local/share/themes
  ln -sf "$HOME/personal/themes" ~/.local/share/themes
  echo "Themes linked"
fi

if [ -d "$HOME/personal/icons" ]; then
  rm -rf ~/.local/share/icons
  ln -sf "$HOME/personal/icons" ~/.local/share/icons
  echo "Icons linked"
fi

# Done!
echo "Setup complete!"
