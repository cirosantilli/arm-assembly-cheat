.POSIX:

PREFIX = arm-linux-gnueabihf-
CC = $(PREFIX)gcc
OBJDUMP = $(PREFIX)objdump
CFLAGS = -ggdb3 -march=armv7-a -marm -pedantic -static -Wall -Wextra #-mthumb
DRIVER_BASENAME = main
IN_EXT = .S
OBJ_EXT = .o
OBJDUMP_EXT = .objdump
OUT_EXT = .out
RUN_CMD = qemu-arm -L /usr/arm-linux-gnueabihf
RUN = hello_driver
TEST = test
DRIVER_OBJ = $(DRIVER_BASENAME)$(OBJ_EXT)

-include params.mk

INS_NOEXT := $(basename $(wildcard *$(IN_EXT)))
OUTS := $(addsuffix $(OUT_EXT), $(INS_NOEXT))
OBJDUMPS := $(addsuffix $(OBJDUMP_EXT), $(INS_NOEXT))

.PHONY: all clean objdump test
.PRECIOUS: %$(OBJ_EXT)

all: $(OUTS) hello_c$(OUT_EXT)

objdump: $(OBJDUMPS)

hello_c$(OUT_EXT): hello_c.c
	$(CC) $(CFLAGS) -o '$@' '$<'

%$(OUT_EXT): %$(OBJ_EXT) $(DRIVER_OBJ)
	$(CC) $(CFLAGS) -o '$@' '$<' $(DRIVER_OBJ)

%$(OBJDUMP_EXT): %$(OUT_EXT)
	$(OBJDUMP) -S '$<' > '$@'

%$(OBJ_EXT): %$(IN_EXT) common.h
	$(CC) $(CFLAGS) -c -o '$@' '$<'

$(DRIVER_OBJ): $(DRIVER_BASENAME).c
	$(CC) $(CFLAGS) -c -o '$@' '$<'

clean:
	rm -f *.o *objdump *.out

gdb-%: %$(OUT_EXT)
	$(RUN_CMD) -g 1234 '$<' &
	gdb-multiarch -q \
	  --nh \
	  -ex 'set architecture arm' \
	  -ex 'file $<' \
	  -ex 'target remote localhost:1234' \
	  -ex 'break asm_main' \
	  -ex 'continue' \
	  -ex 'layout split' \
	;

test-%: %$(OUT_EXT)
	$(RUN_CMD) '$<'

test: all
	@\
	if [ -x $(TEST) ]; then \
	  ./$(TEST) '$(OUT_EXT)' ;\
	else\
	  fail=false ;\
	  for t in *"$(OUT_EXT)"; do\
	    if ! $(RUN_CMD) "$$t"; then \
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
