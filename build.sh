#!/bin/bash

# GCC bare build, we can use gcc build target
# http://8.210.111.180/share/doc/compile/gcc.pdf
function gcc_bare_build()
{
    # Step1 : compile .c to .o , -I specify header search dir
    gcc -c sub/sub.c -Isub
    gcc -c main.c -Isub

    # Step2 : compile .o to binary
    gcc sub.o main.o -o main
    ./main

    # Integrated into one command
    gcc main.c sub/sub.c -Isub -o main_b
    ./main_b

    # -g is debug option, with this, you can use gdb to debug the binary(start, b, info reg etc)
    gcc -g main.c sub/sub.c -Isub -o main_g
    ./main_g
}

cmd_help()
{
    echo "Basic build:"
    echo "$0 h         ---> command help"
    echo "$0 gcc       ---> gcc bare build"
    echo "$0 c         ---> clean"
}

if [[ $1  = "h" ]]; then
    cmd_help
elif [[ $1  = "gcc" ]]; then
    gcc_bare_build
elif [[ $1  = "c" ]]; then
    rm main.o sub.o
    rm main main_b main_g
else
	echo "wrong args."
	cmd_help
fi
