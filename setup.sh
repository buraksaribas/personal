#!/bin/bash

set -e

echo "🔧 Starting Arch Linux + Hyprland setup..."

# -----------------------------------
# 🌐 Update mirror list
# -----------------------------------
echo "🌐 Updating mirror list..."
sudo pacman -S --noconfirm reflector
sudo reflector --latest 10 --sort rate --fastest 5 --save /etc/pacman.d/mirrorlist

# -----------------------------------
# 📦 Official packages
# -----------------------------------
packages=(
    base-devel
    git
    curl
    wget
    zip
    unzip
    rsync
    zsh
    fzf
    neovim
    alacritty
    waybar
    wofi
    hyprpaper
    hyprlock
    hypridle
    hyprsunset
    brightnessctl
    wl-clipboard
    tlp
    bluez
    bluez-utils
    pavucontrol
    vlc
    ufw
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ttf-jetbrains-mono-nerd
    rustup
    go
    docker
    gimp
    inkscape
)

# -----------------------------------
# 📥 Install packages
# -----------------------------------
echo "📦 Installing official packages..."
sudo pacman -Syu --noconfirm
sudo pacman -S --noconfirm --needed "${packages[@]}"

# -----------------------------------
# 🔐 Enable UFW and TLP
# -----------------------------------
echo "🔐 Enabling UFW and TLP..."
sudo ufw enable
sudo systemctl enable --now tlp

# -----------------------------------
# 🐳 Enable Docker
# -----------------------------------
echo "🐳 Enabling Docker..."
sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"

# -----------------------------------
# 🦀 Set up Rust
# -----------------------------------
echo "🦀 Installing Rust (stable)..."
rustup default stable

# -----------------------------------
# 🚀 Install Paru (AUR helper)
# -----------------------------------
if ! command -v paru &> /dev/null; then
    echo "📦 Installing Paru..."
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si --noconfirm
    cd ~
else
    echo "✅ Paru already installed."
fi

# -----------------------------------
# 🎯 Install AUR packages
# -----------------------------------
aur_packages=(
    ghostty
    wlogout
    visual-studio-code-bin
)

echo "📦 Installing AUR packages..."
paru -S --noconfirm "${aur_packages[@]}"

# -----------------------------------
# 🔗 Link dotfiles
# -----------------------------------
echo "🔗 Linking dotfiles..."

mkdir -p ~/.config

for file in .zshrc .bashrc .gitconfig; do
    ln -sf ~/dotfiles/$file ~/$file
done

for config in nvim hypr waybar wofi alacritty; do
    ln -sf ~/dotfiles/.config/$config ~/.config/$config
done

# -----------------------------------
# 🐚 Set Zsh as default shell
# -----------------------------------
if [[ "$SHELL" != *zsh ]]; then
    echo "⚙️ Setting Zsh as default shell..."
    chsh -s /bin/zsh
fi

echo "✅ Setup complete. Please reboot your system!"

