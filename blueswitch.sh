#!/bin/bash

MOUSE_ID=3c-a6-f6-c4-8d-ba
KEYBOARD_ID=ac-49-db-f3-04-be

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
    echo "Paring mouse..."
    blueutil --pair ${MOUSE_ID}
    sleep 3
    BluetoothConnector --connect ${MOUSE_ID}
    sleep 3
    echo "Pairing keyboard..."
    blueutil --pair ${KEYBOARD_ID}
    sleep 3
    BluetoothConnector --connect ${KEYBOARD_ID}
fi


