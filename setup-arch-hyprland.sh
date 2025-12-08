#!/bin/bash
set -e

pacman -Sy --noconfirm

pacman -S --noconfirm --needed \
  base-devel ntfs-3g os-prober firefox git brightnessctl mise bash-completion \
  waybar hyprpicker libnotify speech-dispatcher hyprsunset wl-clipboard \
  hyprlock hypridle qt6ct qt5ct kvantum pavucontrol-qt neovim docker \
  docker-compose docker-buildx ufw earlyoom tlp gimp inkscape vlc \
  vlc-plugin-ffmpeg xournalpp fd fzf lazygit tree-sitter-cli imagemagick unrar

systemctl enable --now earlyoom
systemctl enable tlp.service

usermod -aG docker $USER
newgrp docker

ufw enable
systemctl enable ufw

if ! command -v paru &>/dev/null; then
  echo "Paru kuruluyor..."
  git clone https://aur.archlinux.org/paru.git /tmp/paru
  cd /tmp/paru
  makepkg -si --noconfirm
  cd ~
  rm -rf /tmp/paru
fi

paru -S --noconfirm --needed brave-bin lazydocker
