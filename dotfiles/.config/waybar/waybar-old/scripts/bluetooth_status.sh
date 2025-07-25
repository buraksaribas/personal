#!/bin/bash

power=$(bluetoothctl show | grep "Powered: yes")

if [[ -z "$power" ]]; then
    echo "{\"text\": \" off\", \"tooltip\": \"Bluetooth off\"}"
    exit 0
fi

connected=$(bluetoothctl info | grep "Connected: yes")

if [[ -n "$connected" ]]; then
    name=$(bluetoothctl info | grep "Name:" | cut -d ' ' -f2-)
    echo "{\"text\": \" $name\", \"tooltip\": \"Connected: $name\"}"
else
    echo "{\"text\": \" on\", \"tooltip\": \"Bluetooth on, not connected\"}"
fi

