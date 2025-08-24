#!/bin/bash

chosen=$(printf " Lock\n Shutdown\n Reboot\n Logout\n Suspend\n Hibernate" | rofi -dmenu -i -p "Power")

case "$chosen" in
  *Lock*) swaylock ;;
  *Shutdown*) systemctl poweroff ;;
  *Reboot*) systemctl reboot ;;
  *Logout*)  swaymsg exit ;;
  *Suspend*) systemctl suspend ;;
  *Hibernate*) systemctl hibernate ;;
  *) exit 0 ;;
esac

