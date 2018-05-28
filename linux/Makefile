.POSIX:

# TODO generalize and factor out with the top-level Makefile.
# Leaving this simplified copy paste for now that there is a single example.

.PHONY: all

all:
	arm-linux-gnueabihf-gcc -ggdb3 -Wall -Wextra -pedantic -marm -c -o hello.o hello.S
	arm-linux-gnueabihf-ld -o hello.out hello.o
	qemu-arm -L /usr/arm-linux-gnueabihf hello.out

clean:
	rm -f *.o *.out
