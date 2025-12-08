#!/bin/bash

# İkonlar (nerd fonts kullanıyorsan çalışır)
lock="  Lock"
suspend="  Suspend"
logout="  Logout"
shutdown="  Shutdown"
reboot="  Reboot"
hibernate="󰤄  Hibernate"

chosen=$(printf "%s\n%s\n%s\n%s\n%s\n%s" "$lock" "$suspend" "$logout" "$hibernate" "$reboot" "$shutdown" | wofi --dmenu --prompt "Power Menu" --width 400 --height 300 --lines 6 --cache-file /dev/null --conf ~/.config/wofi/power.conf)

case "$chosen" in
    "$lock")      hyprlock || swaylock -f -c 000000 ;;
    "$suspend")   systemctl suspend ;;
    "$logout")    hyprctl dispatch exit || loginctl terminate-session ${XDG_SESSION_ID-} ;;
    "$hibernate") systemctl hibernate ;;
    "$reboot")    systemctl reboot ;;
    "$shutdown")  systemctl poweroff ;;
    *)            exit 1 ;;
esac
