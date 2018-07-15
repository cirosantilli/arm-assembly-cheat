.POSIX:

CC = $(PREFIX_PATH)-gcc
# no-pie: https://stackoverflow.com/questions/51310756/how-to-gdb-step-debug-a-dynamically-linked-executable-in-qemu-user-mode
CFLAGS = -fno-pie -ggdb3 -march=$(MARCH) -pedantic -no-pie -Wall -Wextra #-mthumb
CTNG =
DRIVER_BASENAME = main
DRIVER_OBJ = $(DRIVER_BASENAME)$(OBJ_EXT)
IN_EXT = .S
MARCH = armv7-a
OBJDUMP = $(PREFIX_PATH)-objdump
OBJDUMP_EXT = .objdump
OBJ_EXT = .o
OUT_EXT = .out
PREFIX = arm-linux-gnueabihf
QEMU_EXE = qemu-arm
RUN_CMD = $(QEMU_EXE) -L $(SYSROOT)
GDB_PORT = 1234
TEST = test

ifeq ($(CTNG),)
  PREFIX_PATH = $(PREFIX)
  SYSROOT = /usr/arm-linux-gnueabihf
else
  PREFIX_PATH = $(CTNG)/$(PREFIX)/bin/$(PREFIX)
  SYSROOT = $(CTNG)/$(PREFIX)/$(PREFIX)/sysroot
endif

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
	$(RUN_CMD) -g $(GDB_PORT) '$<' &
	gdb-multiarch -q \
	  -nh \
	  -ex 'set confirm off'  \
	  -ex 'set architecture arm' \
	  -ex 'set sysroot $(SYSROOT)' \
	  -ex 'file $<' \
	  -ex 'target remote localhost:$(GDB_PORT)' \
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
