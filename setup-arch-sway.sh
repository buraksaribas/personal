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
  firefox fuse3 fzf gimp git grim htop \
  inkscape lazygit libnotify libpulse libvirt \
  man-db mtools mise nano neovim \
  ntfs-3g openbsd-netcat os-prober \
  qemu-full ripgrep \
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
