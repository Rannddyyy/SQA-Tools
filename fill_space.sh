#!/bin/bash
# Program: Fill android's devices' storage space with dumpy file
# ------------------------------------------------------

function print_usage() {
    echo "usage: $0 [-r|SIZE]"
    echo ""
    echo "Options:"
    echo "  -r"
    echo "      remove dummy file which located at /sdcard/.tmp_fill"
    echo "  SIZE"
    echo "      remaining available space's size(MB)"
    echo ""
}

function fill_space() {
	current_free_size=`adb shell df /data | grep /data | awk '{print $4}'`

	if [[ "$current_free_size" =~ ^[0-9\.]+G$ ]]; then
	    current_free_size=`echo $current_free_size | sed -e 's/G/*1024*1024/' | bc`
	elif [[ "$current_free_size" =~ ^[0-9\.]+M$ ]]; then
	    current_free_size=`echo $current_free_size | sed -e 's/M/*1024/' | bc`
	fi
   
	size_to_increase=`echo "$current_free_size/1024 - $increase_size" | bc`
	echo "Current available storage space = $((${current_free_size}/1024)) MB"
	echo "Size to increase = $size_to_increase MB"
	final_size=`adb shell ls -l "${dummy_filename}" | awk -v size_to_increase=${size_to_increase} '{print $5+size_to_increase*1024*1024}'`
	echo "Dummy file size will be $((${final_size}/1024/1024)) MB ($((${final_size}/1024/1024/1024)) GB)"
	echo "Starting produce dummy file..."
	if (( size_to_increase <= 0)); then
	    adb shell truncate -s $final_size "${dummy_filename}"
	else
	    adb shell "dd if=/dev/zero bs=1048576 count=$size_to_increase >> ${dummy_filename}"
	fi

	echo ""
	current_free_size=`adb shell df /data | grep /data | awk '{print $4}'`
	echo "Current available storage space = $((${current_free_size}/1024)) MB"
	echo ""
}

dummy_filename="/sdcard/.tmp_fill"
adb shell touch "${dummy_filename}"

increase_size=""
re="^[0-9]+$"
if [[ $# -ne 1 ]]; then 
	print_usage && exit 1
elif [[ "$1" = "-r" ]]; then 
	adb shell rm ${dummy_filename} && echo "${dummy_filename} has be removed." && exit 1
elif [[ $1 =~ $re ]]; then 
	increase_size=$1
	fill_space
else 
	print_usage && exit 1
fi
