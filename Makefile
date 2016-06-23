.POSIX:

.PHONY: all

all:
	arm-linux-gnueabihf-as -o hello.o hello.S
	arm-linux-gnueabihf-ld -o hello.out hello.o
	qemu-arm-static -L /usr/arm-linux-gnueabihf hello.out
	arm-linux-gnueabihf-gcc -o hello_c.out hello_c.c
	qemu-arm-static -L /usr/arm-linux-gnueabihf hello_c.out

clean:
	rm -f *.o *.out
