.POSIX:

.PHONY: all

AS := arm-linux-gnueabihf-as -g
CCC := arm-linux-gnueabihf-gcc -ggdb3
RUN := qemu-arm-static -L /usr/arm-linux-gnueabihf

all:
	$(AS) -o hello.o hello.S
	arm-linux-gnueabihf-ld -o hello.out hello.o
	$(RUN) hello.out
	$(CCC) -o hello_c.out hello_c.c
	$(RUN) hello_c.out
	$(CCC) -c -o driver.o driver.c
	$(AS) -o hello_driver.o hello_driver.S
	$(CCC) -o hello_driver.out driver.o hello_driver.o
	$(RUN) hello_driver.out

clean:
	rm -f *.o *.out

debug:
	$(RUN) -g 1234 hello_driver.out &
	gdb-multiarch -q -ex 'set architecture arm' -ex 'file hello_driver.out' -ex 'target remote localhost:1234'
