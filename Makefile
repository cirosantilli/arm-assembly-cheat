.POSIX:

.PHONY: all

CCC := arm-linux-gnueabihf-gcc -ggdb3 -Wextra -pedantic -marm #-mthumb
DEBUG ?= hello_linux.out
RUN := qemu-arm-static -L /usr/arm-linux-gnueabihf

all:
	## Driverless examples.
	$(CCC) -c -o hello_linux.o hello_linux.S
	arm-linux-gnueabihf-ld -o hello_linux.out hello_linux.o
	$(RUN) hello_linux.out
	#
	$(CCC) -o hello_c.out hello_c.c
	$(RUN) hello_c.out
	## ARM driver examples.
	$(CCC) -c -o driver.o driver.c
	#
	$(CCC) -c -o hello_driver.o hello_driver.S
	$(CCC) -o hello_driver.out driver.o hello_driver.o
	$(RUN) hello_driver.out
	#
	$(CCC) -c -o c_from_arm.o c_from_arm.S
	$(CCC) -o c_from_arm.out driver.o c_from_arm.o
	$(RUN) c_from_arm.out
	#
	$(CCC) -c -o first_branch.o first_branch.S
	$(CCC) -o first_branch.out driver.o first_branch.o
	$(RUN) first_branch.out
	#
	$(CCC) -c -o function.o function.S
	$(CCC) -o function.out driver.o function.o
	$(RUN) function.out
	## Thumb driver examples.
	$(CCC) -c -o driver_thumb.o driver_thumb.c
	#
	$(CCC) -c -o thumb.o thumb.S
	$(CCC) -o thumb.out driver_thumb.o thumb.o
	$(RUN) thumb.out

clean:
	rm -f *.o *.out

debug:
	$(RUN) -g 1234 '$(DEBUG)' &
	gdb-multiarch -q -ex 'set architecture arm' -ex 'file $(DEBUG)' -ex 'target remote localhost:1234'
