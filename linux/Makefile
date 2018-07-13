.POSIX:

# TODO generalize and factor out with the top-level Makefile.
# Leaving this simplified copy paste for now that there is a single example.

.PHONY: all run clean

all:
	arm-linux-gnueabihf-gcc -ggdb3 -marm -o hello.out -nostdlib -pedantic -static -Wall -Wextra hello.S

gdb: all
	qemu-arm -g 1234 hello.out &
	gdb-multiarch -q --nh -ex 'set architecture arm' -ex 'file hello.out' -ex 'target remote localhost:1234' -ex 'layout split'

run: all
	qemu-arm -L /usr/arm-linux-gnueabihf hello.out

clean:
	rm -f *.o *.out
