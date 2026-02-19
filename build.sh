#!/bin/bash

SRC_DIR="src/"
TARGET="bin/prog"

check_errors()
{
    if [ $? -ne 0 ]; then
        exit 1
    fi
}

read -p "Tap : 1(or nothing) build | 2 clean | 3 rebuild | 4 debug >> " -n 1 -r compile_choice
clear

if [ "$compile_choice" == "1" ] || [ "$compile_choice" == "" ]; then
    make all
	check_errors
elif [ "$compile_choice" == "2" ]; then
    make clean
	exit
elif [ "$compile_choice" == "3" ]; then
    make rebuild
	check_errors
elif [ "$compile_choice" == "4" ]; then
	make debug
	check_errors
	gdb bin/prog
	exit 
else
    echo "Abort..."
fi

read -p "Run it? [Y/n] " -n 1 -r run_choice
clear

if [ "$run_choice" == "y" ] || [ "$run_choice" == "y" ] || [ "$run_choice" == "" ]; then
	$TARGET
    exit $?
fi
exit