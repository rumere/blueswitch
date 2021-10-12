#!/bin/bash

set -ex

MOUSE_ID=a8-be-27-d9-a2-4d
KEYBOARD_ID=40-e6-4b-8e-12-9a

MOUSE_STATE=`blueutil --is-connected ${MOUSE_ID}`
KEYBOARD_STATE=`blueutil --is-connected ${KEYBOARD_ID}`

if [ ${MOUSE_STATE} == 1 ]; then
    BluetoothConnector --disconnect ${MOUSE_ID}
    if [ $KEYBOARD_STATE == 1 ]; then
        BluetoothConnector --disconnect ${KEYBOARD_ID}
    fi
    sleep 3
    blueutil -p 0
    sleep 3
else
    blueutil -p 1
    echo "Restart devices..."
    sleep 15
    blueutil --pair ${MOUSE_ID}
    BluetoothConnector --connect ${MOUSE_ID}
    blueutil --pair ${KEYBOARD_ID}
    BluetoothConnector --connect ${KEYBOARD_ID}
fi

