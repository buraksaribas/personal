#!/bin/bash

LOCATION="Istanbul"

WEATHER=$(curl -s "wttr.in/$LOCATION?format=%c%t+%C")

if [[ $? -ne 0 ]]; then
    echo "{\"text\": \"󰜺\", \"tooltip\": \"Unable to fetch weather\"}"
    exit 1
fi

read -r ICON TEMP CONDITION <<< "$WEATHER"

case "$CONDITION" in
    *Sunny*) ICON="󰖙" ;;
    *Cloudy*) ICON="󰖐" ;;
    *Rain*) ICON="󰖖" ;;
    *Snow*) ICON="󰖘" ;;
    *Fog*) ICON="󰖑" ;;
    *Mist*) ICON="󰖑" ;;
    *) ICON="󰖙" ;;
esac

echo "{\"text\": \"$ICON $TEMP\", \"tooltip\": \"$CONDITION, $TEMP\"}"
