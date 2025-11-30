#!/bin/bash

BLUETOOTH_DIR="$HOME/.cache/waybar-bluetooth"
KNOWN_DEVICES_FILE="$BLUETOOTH_DIR/known_devices"

mkdir -p "$BLUETOOTH_DIR"

# Functions
get_bluetooth_status() {
    if command -v bluetoothctl >/dev/null 2>&1; then
        bluetoothctl show | grep -q "Powered: yes" && echo "on" || echo "off"
    else
        echo "off"
    fi
}

toggle_bluetooth() {
    if [[ $(get_bluetooth_status) == "on" ]]; then
        bluetoothctl power off
        notify-send "Bluetooth" "Bluetooth turned off" -i bluetooth-disabled
    else
        bluetoothctl power on
        notify-send "Bluetooth" "Bluetooth turned on" -i bluetooth-active
    fi
}

get_paired_devices() {
    bluetoothctl devices Paired 2>/dev/null | while read -r device; do
        mac=$(echo "$device" | awk '{print $2}')
        name=$(echo "$device" | cut -d' ' -f3-)
        connected=$(bluetoothctl info "$mac" 2>/dev/null | grep -q "Connected: yes" && echo "🔗" || echo "")
        echo "$mac|$name|$connected"
    done
}

connect_device() {
    local mac="$1"
    local name="$2"
    
    if bluetoothctl connect "$mac"; then
        notify-send "Bluetooth" "Connected to $name" -i bluetooth-active
    else
        notify-send "Bluetooth" "Failed to connect to $name" -i dialog-error
    fi
}

disconnect_device() {
    local mac="$1"
    local name="$2"
    
    if bluetoothctl disconnect "$mac"; then
        notify-send "Bluetooth" "Disconnected from $name" -i bluetooth-disabled
    else
        notify-send "Bluetooth" "Failed to disconnect from $name" -i dialog-error
    fi
}

scan_and_add_device() {
    notify-send "Bluetooth" "Scanning for new devices..." -i bluetooth-active
    bluetoothctl scan on >/dev/null 2>&1 &
    SCAN_PID=$!
    sleep 8
    kill $SCAN_PID 2>/dev/null
    bluetoothctl scan off >/dev/null 2>&1

    # List discovered devices (all devices - paired)
    discovered=$(bluetoothctl devices | awk '{mac=$2; name=$3; for (i=4;i<=NF;i++) name=name" "$i; print mac"|"name}')
    paired_macs=$(bluetoothctl devices Paired | awk '{print $2}')

    for pmac in $paired_macs; do
        discovered=$(echo "$discovered" | grep -v "^$pmac|")
    done

    if [[ -z "$discovered" ]]; then
        notify-send "Bluetooth" "No new devices found" -i dialog-information
        return
    fi

    # Menu for discovered devices
    if command -v rofi >/dev/null 2>&1; then
        choice=$(echo "$discovered" | cut -d'|' -f2 | rofi -dmenu -p "Pair device:")
    elif command -v dmenu >/dev/null 2>&1; then
        choice=$(echo "$discovered" | cut -d'|' -f2 | dmenu -p "Pair device:")
    else
        notify-send "Bluetooth" "Neither rofi nor dmenu found" -i dialog-error
        return
    fi

    [[ -z "$choice" ]] && return

    device_mac=$(echo "$discovered" | grep "|$choice" | cut -d'|' -f1)

    if bluetoothctl pair "$device_mac"; then
        notify-send "Bluetooth" "Paired with $choice" -i bluetooth-active
        bluetoothctl trust "$device_mac"
        connect_device "$device_mac" "$choice"
    else
        notify-send "Bluetooth" "Failed to pair with $choice" -i dialog-error
    fi
}

show_device_menu() {
    if [[ $(get_bluetooth_status) == "off" ]]; then
        notify-send "Bluetooth" "Bluetooth is off" -i bluetooth-disabled
        exit 1
    fi

    devices=$(get_paired_devices)
    
    if [[ -z "$devices" ]]; then
        notify-send "Bluetooth" "No paired devices found" -i dialog-information
    fi

    menu_options="🔄 Toggle Bluetooth\n📡 Scan for Devices\n"
    
    while IFS='|' read -r mac name connected; do
        if [[ -n "$connected" ]]; then
            menu_options+="❌ $name (Disconnect)\n"
        else
            menu_options+="🔗 $name (Connect)\n"
        fi
    done <<< "$devices"

    if command -v rofi >/dev/null 2>&1; then
        choice=$(echo -e "$menu_options" | rofi -dmenu -p "Bluetooth:" -theme-str 'window {width: 400px;}')
    elif command -v dmenu >/dev/null 2>&1; then
        choice=$(echo -e "$menu_options" | dmenu -p "Bluetooth:")
    else
        notify-send "Bluetooth" "Neither rofi nor dmenu found" -i dialog-error
        exit 1
    fi

    case "$choice" in
        "🔄 Toggle Bluetooth")
            toggle_bluetooth
            ;;
        "📡 Scan for Devices")
            scan_and_add_device
            ;;
        "🔗 "*|"❌ "*)
            device_name=$(echo "$choice" | sed 's/^[🔗❌] //' | sed 's/ (Connect)//' | sed 's/ (Disconnect)//')
            device_mac=$(echo "$devices" | grep "|$device_name|" | cut -d'|' -f1)
            
            if [[ "$choice" == "🔗 "* ]]; then
                connect_device "$device_mac" "$device_name"
            else
                disconnect_device "$device_mac" "$device_name"
            fi
            ;;
    esac
}

# Main
case "${1:-menu}" in
    "toggle") toggle_bluetooth ;;
    "on") bluetoothctl power on; notify-send "Bluetooth" "Bluetooth turned on" -i bluetooth-active ;;
    "off") bluetoothctl power off; notify-send "Bluetooth" "Bluetooth turned off" -i bluetooth-disabled ;;
    "connect") [[ -n "$2" ]] && connect_device "$2" "Device" || echo "Usage: $0 connect <MAC>" ;;
    "disconnect") [[ -n "$2" ]] && disconnect_device "$2" "Device" || echo "Usage: $0 disconnect <MAC>" ;;
    "menu"|*) show_device_menu ;;
esac

