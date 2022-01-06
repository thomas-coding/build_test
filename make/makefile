# ------------------------
# Generic Makefile
# ------------------------

# Target is main, depend main.o and sub.o
main : main.o sub.o
		gcc sub.o main.o -o main
		@echo "Compile done"

# Compile main.o, depend on main.c, command is used gcc
main.o : main.c
		gcc -c main.c -Isub

# Compile sub.o, depend on sub.c, command is used gcc
sub.o : sub/sub.c
		gcc -c sub/sub.c -Isub

# Use make clean for rm object and binary
clean :
		rm -rf main main.o sub.o
