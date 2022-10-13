#!/bin/bash


#  level 1(compile)       level 2(build)             level 3(generator)
#      gcc                  make                        cmake
#      clang                ninja                       gn(only support ninja)
#


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

# Clang bare build, we can use clang build target
# https://clang.llvm.org/
function clang_bare_build()
{
    # Step1 : compile .c to .o , -I specify header search dir
    clang -c main.c -Isub
    clang -c sub/sub.c -Isub

    # Step2 : compile .o to binary
    clang main.o sub.o -o main
    ./main

    # Integrated into one command
    clang main.c sub/sub.c -Isub -o main_b
    ./main_b

    # -g is debug option, with this, you can use gdb to debug the binary(start, b, info reg etc)
    clang -g main.c sub/sub.c -Isub -o main_g
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

# cmake build, we can use cmake generate makefile or build.ninja, then used make or ninja to build target
# https://cmake.org/cmake/help/v3.22/
function cmake_build()
{
    echo "Fisrt, use make"

    mkdir -p build
    cd build

    # Use cmake generate makefile, specify CMakeLists.txt dir
    cmake ../cmake

    # Call that build system to actually compile/link the project, The same as make
    cmake --build .

    ./main

    echo "Then, use ninja"

    cd ..
    rm -rf build
    mkdir -p build
    cd build

    # Use cmake generate build.ninja, specify CMakeLists.txt dir
    cmake -G Ninja ../cmake

    # Call that build system to actually compile/link the project, The same as ninja
    cmake --build .

    ./main
}

# gn build, we can use cmake generate build.ninja, then used ninja to build target
# https://gn.googlesource.com/gn/
function gn_build()
{
    cd gn

    # Generate ninja file to out/build
    /root/workspace/software/gn/out/gn gen out/build

    # Used ninja to build target
    ninja -C out/build/

    ./out/build/main
}

function scons_build()
{
    cd scons
    scons
}

cmd_help()
{
    echo "Basic build:"
    echo "$0 h         ---> command help"
    echo "$0 gcc       ---> use gcc bare build"
    echo "$0 clang     ---> use gcc bare build"
    echo "$0 make      ---> use make build"
    echo "$0 ninja     ---> use ninja build"
    echo "$0 cmake     ---> use cmake build"
    echo "$0 gn        ---> use gn build"
    echo "$0 c         ---> clean"
}

if [[ $1  = "h" ]]; then
    cmd_help
elif [[ $1  = "gcc" ]]; then
    gcc_bare_build
elif [[ $1  = "clang" ]]; then
    clang_bare_build
elif [[ $1  = "make" ]]; then
    make_build
elif [[ $1  = "ninja" ]]; then
    ninja_build
elif [[ $1  = "cmake" ]]; then
    cmake_build
elif [[ $1  = "gn" ]]; then
    gn_build
elif [[ $1  = "scons" ]]; then
    scons_build
elif [[ $1  = "c" ]]; then
    rm -rf main.o sub.o sub/sub.o
    rm -rf main main_b main_g
    make clean -f make/makefile
    ninja -f ninja/build.ninja -t clean
    rm -rf .ninja_deps .ninja_log
    rm -rf build
    rm -rf gn/out
    rm -rf scons/hello scons/.sconsign.dblite
else
	echo "wrong args."
	cmd_help
fi
