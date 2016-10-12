.POSIX:

.PHONY: all

CCC ?= arm-linux-gnueabihf-gcc -ggdb3 -Wall -Wextra -pedantic -marm #-mthumb
DEBUG ?= hello_linux.out
IN_EXT ?= .S
OBJ_EXT ?= .o
OUT_EXT ?= .out
RUN_CMD ?= qemu-arm-static -L /usr/arm-linux-gnueabihf
RUN ?= hello_driver
TEST ?= test

OUTS := $(addsuffix $(OUT_EXT), $(basename $(wildcard *$(IN_EXT))))

## Driverless examples. TODO.
#$(CCC) -c -o hello_linux.o hello_linux.S
#arm-linux-gnueabihf-ld -o hello_linux.out hello_linux.o
#$(RUN_CMD) hello_linux.out
##
#$(CCC) -o hello_c.out hello_c.c
#$(RUN_CMD) hello_c.out

all: $(OUTS)

%$(OUT_EXT): %$(OBJ_EXT) main.o
	$(CCC) -o '$@' '$<' main.o

%$(OBJ_EXT): %$(NASM_EXT)
	$(CCC) -c -o '$@' '$<'

main.o: main.c
	$(CCC) -c -o '$@' '$<'

clean:
	rm -f *.o *.out

debug:
	$(RUN_CMD) -g 1234 '$(DEBUG)' &
	gdb-multiarch -q -ex 'set architecture arm' -ex 'file $(DEBUG)' -ex 'target remote localhost:1234'

run: all
	$(RUN_CMD) '$(RUN)$(OUT_EXT)'

test: all
	@\
	if [ -x $(TEST) ]; then \
	  ./$(TEST) '$(OUT_EXT)' ;\
	else\
	  fail=false ;\
	  for t in *"$(OUT_EXT)"; do\
	    if ! ./"$$t"; then \
	      fail=true ;\
	      break ;\
	    fi ;\
	  done ;\
	  if $$fail; then \
	    echo "TEST FAILED: $$t" ;\
	    exit 1 ;\
	  else \
	    echo 'ALL TESTS PASSED' ;\
	    exit 0 ;\
	  fi ;\
	fi ;\
