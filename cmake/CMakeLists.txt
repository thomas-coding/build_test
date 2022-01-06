cmake_minimum_required(VERSION 3.10)

# set the project name
project(main)

include_directories(../sub)

# add the executable
add_executable(main ../main.c ../sub/sub.c)
