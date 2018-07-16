.POSIX:

# TODO generalize and factor out with the top-level Makefile.
# Leaving this simplified copy paste for now that there is a single example.

.PHONY: all test clean

all: hello.out

hello.out: hello.S
	arm-linux-gnueabihf-gcc -ggdb3 -marm -o '$@' -nostdlib -pedantic -static -Wall -Wextra '$<'

clean:
	rm -f *.o *.objdump *.out

gdb: all
	qemu-arm -g 1234 hello.out &
	gdb-multiarch -q --nh -ex 'set architecture arm' -ex 'file hello.out' -ex 'target remote localhost:1234' -ex 'layout split'

objdump: hello.out
	arm-linux-gnueabihf-objdump -S '$<' > hello.objdump

test: all
	qemu-arm -L /usr/arm-linux-gnueabihf hello.out
