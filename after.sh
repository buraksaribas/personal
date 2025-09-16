sudo pacman -Syu --nocinform

sudo pacman -S --noconfirm \
  git \
	firefox \
	libreoffice-fresh \
	htop \
	gimp \
	inkscape \
	ufw \
	vlc \
	speech-dispatcher \
	ttf-jetbrains-mono-nerd \
	man \
	mako \
	waybar \
	libnotify \
	rofi \
	wlsunset \
	wl-clipboard \
	tlp \
	mise \
	bash-completion \
	unzip \
	zip \
  ripgrep \
  docker \
  docker-compose \
  yazi \
  tmux \

# -----------------------------------
# Configure Docker
# -----------------------------------
echo "Configuring Docker..."
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER
echo "Docker configured! (You may need to log out and back in for group changes to take effect)"

# -----------------------------------
# Configure UFW Firewall
# -----------------------------------
echo "Configuring UFW firewall..."
sudo ufw enable
echo "UFW firewall enabled!"

# -----------------------------------
# Configure TLP for power management
# -----------------------------------
echo "Configuring TLP for power management..."
sudo systemctl enable tlp
sudo systemctl start tlp
echo "TLP configured!"

# -----------------------------------
# Link dotfiles
# -----------------------------------
echo "Linking dotfiles..."

# Create .config directory if it doesn't exist
mkdir -p ~/.config

# Check if dotfiles directory exists
DOTFILES_DIR="$HOME/personal/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Warning: Dotfiles directory $DOTFILES_DIR not found!"
    echo "Please make sure you have cloned your dotfiles repository to $DOTFILES_DIR"
    echo "Skipping dotfiles linking..."
else
    echo "Linking configuration files..."
    
    # Link home directory dotfiles
    for file in .zshrc .bashrc .gitconfig; do
        if [ -f "$DOTFILES_DIR/$file" ]; then
            ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
            echo " Linked $file"
        else
            echo " $file not found in dotfiles directory"
        fi
    done
    
    # Link .config directories
    for config in foot tmux mako rofi nvim waybar sway swaylock yazi; do
        target="$HOME/.config/$config"
        source_dir="$DOTFILES_DIR/.config/$config"
        
        if [ -d "$source_dir" ]; then
            # Remove existing directory/symlink
            rm -rf "$target"
            # Create symlink
            ln -sf "$source_dir" "$target"
            echo "  Linked .config/$config"
        else
            echo "  .config/$config not found in dotfiles directory"
        fi
    done
    
    echo "Dotfiles linked successfully!"
fi

echo "Linking fonts and icons..."

# Link fonts
if [ -d "$HOME/personal/fonts" ]; then
    target="$HOME/.local/share/fonts"
    rm -rf "$target"
    ln -sf "$HOME/personal/fonts" "$target"
    echo "   Linked fonts to ~/.local/share/fonts"
    # Refresh font cache
    fc-cache -fv
    echo "   Font cache refreshed"
else
    echo "     ~/personal/fonts directory not found"
fi

# Link icons
if [ -d "$HOME/personal/icons" ]; then
    target="$HOME/.local/share/icons"
    rm -rf "$target"
    ln -sf "$HOME/personal/icons" "$target"
    echo "   Linked icons to ~/.local/share/icons"
else
    echo "     ~/personal/icons directory not found"
fi

echo " Fonts and icons linking completed!"
