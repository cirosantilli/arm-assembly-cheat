.POSIX:
.PHONY: all test clean

all: hello.out

hello.out: hello.S
	aarch64-linux-gnu-gcc -ggdb3 -o '$@' -nostdlib -pedantic -static -Wall -Wextra '$<'

clean:
	rm -f *.o *.objdump *.out

gdb: all
	qemu-aarch64 -g 1234 hello.out &
	gdb-multiarch -q --nh -ex 'set architecture aarch64' -ex 'file hello.out' -ex 'target remote localhost:1234' -ex 'layout split'

objdump: hello.out
	aarch64-linux-gnu-objdump -S '$<' > hello.objdump

test: all
	qemu-aarch64 hello.out
