#!/bin/bash

# GCC bare build, we can use gcc build target
# http://8.210.111.180/share/doc/compile/gcc.pdf
function gcc_bare_build() {
    # -I specify header search dir
    gcc main.c sub/sub.c -Isub -o main

    # -g is debug option, with this, you can use gdb to debug the binary(start, b, info reg etc)
    gcc -g main.c sub/sub.c -Isub -o main

}

gcc_bare_build
