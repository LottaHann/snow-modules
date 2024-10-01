#!/bin/bash

# Initialize variables
CAMERA=""
MODULE=""
VIDEO_DEVICE=""

echo "Choose camera type: 1 = opencv or 2 = pedro"
read choice

check_oak_d_camera() {
    if lsusb | grep -q "03e7:2485"; then
        echo "DepthAI OAK-D camera detected. Opencv available"
        
    else
        echo -e "Warning! DepthAI OAK-D camera not found. \nIf device address is other than 03e7:2465 \n you can ignore this message."
        echo "Ignore? y/n"
        read ignore

        if [ "$ignore" == "y" ]; then
            echo "Continuing..."
        elif [ "$ignore" == "n" ]; then
            echo "Shutting down, please reconnect or run with pedro module."
            exit 0
        else
            echo "Something went wrong, contact supervisor"
            exit 1
        fi
    fi
}



if [ "$choice" == "1" ]; then
    CAMERA="opencv"
    echo "Selected camera type: opencv"
    check_oak_d_camera
elif [ "$choice" == "2" ]; then
    CAMERA="pedro"
    echo "Selected camera type: pedro"
    
    echo "Enter the device number for pedro (e.g., 0 for /dev/video0):"
    read device_number
    
    if [ -e "/dev/video$device_number" ]; then
        VIDEO_DEVICE="/dev/video$device_number"
        MODULE="$device_number"
        echo "Selected camera module: $MODULE"
    else
        echo "Error: /dev/video$device_number does not exist."
        exit 1
    fi
else
    echo "Invalid choice. Please run the script again and choose 1 or 2."
    exit 1
fi

echo "Starting Docker with environment variables..."
if [ "$CAMERA" == "opencv" ]; then
    CAMERA="$CAMERA" docker compose up
else
    CAMERA="$CAMERA" MODULE="$MODULE" VIDEO_DEVICE="$VIDEO_DEVICE" docker compose up
fi