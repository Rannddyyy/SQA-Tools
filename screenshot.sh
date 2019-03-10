#!/bin/bash
# Program: Get android devices' screenshot and pull into Desktop
# ------------------------------------------------------

FILE_NAME="`date +%Y%m%d_%H%M%S`.png"
LOCATE="/sdcard/Download/$FILE_NAME"
adb shell screencap -p $LOCATE
adb pull $LOCATE $HOME/Desktop
adb shell rm $LOCATE
if [[ -f $HOME/Desktop/$FILE_NAME ]]; then
    echo "Screenshot \033[0;36m$FILE_NAME\033[0m has been saved at \033[0;33m$HOME/Desktop\033[0m"
fi
