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

# make build, we can use make and define makefile to build target
# http://8.210.111.180/share/doc/compile/make.pdf
function make_build()
{
    make -f make/makefile
    ./main
}

# ninja build, we can use ninja and define ninja to build target
# https://ninja-build.org/manual.html
function ninja_build()
{
    ninja  -f ninja/build.ninja
    ./main
}

cmd_help()
{
    echo "Basic build:"
    echo "$0 h         ---> command help"
    echo "$0 gcc       ---> use gcc bare build"
    echo "$0 make      ---> use make build"
    echo "$0 make      ---> use ninja build"
    echo "$0 c         ---> clean"
}

if [[ $1  = "h" ]]; then
    cmd_help
elif [[ $1  = "gcc" ]]; then
    gcc_bare_build
elif [[ $1  = "make" ]]; then
    make_build
elif [[ $1  = "ninja" ]]; then
    ninja_build
elif [[ $1  = "c" ]]; then
    rm -rf main.o sub.o
    rm -rf main main_b main_g
    make clean -f make/makefile
    ninja -f ninja/build.ninja -t clean
    rm -rf .ninja_deps .ninja_log
else
	echo "wrong args."
	cmd_help
fi
