#!/bin/bash

# Tema dosyalarının yolu
THEME_DIR="$HOME/.config/waybar/themes"
HYPRLAND_CONF="$HOME/.config/hypr/hyprland.conf"
WAYBAR_STYLE="$HOME/.config/waybar/style.css"

# Mevcut Catppuccin temaları
THEMES=("latte" "frappe" "macchiato" "mocha")
CURRENT_THEME=$(grep "catppuccin-" "$WAYBAR_STYLE" | cut -d'-' -f2 | cut -d'.' -f1)

# Rofi ile tema seçimi
CHOICE=$(printf "%s\n" "${THEMES[@]}" | rofi -dmenu -i -p "Tema Seç")

if [[ -z "$CHOICE" ]]; then
    exit 0
fi

# Waybar teması değiştir
sed -i "s/catppuccin-$CURRENT_THEME.css/catppuccin-$CHOICE.css/" "$WAYBAR_STYLE"

# Hyprland teması değiştir (örnek: wallpaper ve renk şeması)
case "$CHOICE" in
    latte)
        sed -i 's/source = .*/source = ~\/.config\/hypr\/themes\/latte.conf/' "$HYPRLAND_CONF"
        ;;
    frappe)
        sed -i 's/source = .*/source = ~\/.config\/hypr\/themes\/frappe.conf/' "$HYPRLAND_CONF"
        ;;
    macchiato)
        sed -i 's/source = .*/source = ~\/.config\/hypr\/themes\/macchiato.conf/' "$HYPRLAND_CONF"
        ;;
    mocha)
        sed -i 's/source = .*/source = ~\/.config\/hypr\/themes\/mocha.conf/' "$HYPRLAND_CONF"
        ;;
esac

# Waybar’ı yeniden başlat
pkill waybar
waybar &

# Bildirim (isteğe bağlı)
notify-send "Tema Değiştirildi" "Yeni tema: Catppuccin $CHOICE"
