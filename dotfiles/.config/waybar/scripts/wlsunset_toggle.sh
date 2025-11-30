#!/usr/bin/env bash

if pgrep -x wlsunset >/dev/null; then
  pkill wlsunset
  notify-send -u low "wlsunset" "wlsunset off" -t 1500
else
  wlsunset -l 41.0 -L 29.0 -t 3500 -T 6500 -g 0.8 &
  notify-send -u low "wlsunset" "wlsunset 3500K on" -t 1500
fi
