.POSIX:

ARCH = arm
CC = $(PREFIX_PATH)-gcc
# no-pie: https://stackoverflow.com/questions/51310756/how-to-gdb-step-debug-a-dynamically-linked-executable-in-qemu-user-mode
CFLAGS = -fno-pie -ggdb3 -march=$(MARCH) -pedantic -no-pie -std=c99 -Wall -Wextra $(CFLAGS_EXTRA)
CTNG =
DEFAULT_SYSROOT = /usr/$(PREFIX)
DRIVER_BASENAME = main
DRIVER_OBJ = $(DRIVER_BASENAME)$(OBJ_EXT)
GDB_PORT = 1234
IN_EXT = .S
MARCH = armv7-a
OBJDUMP = $(PREFIX_PATH)-objdump
OBJDUMP_EXT = .objdump
OBJ_EXT = .o
OUT_EXT = .out
PREFIX = arm-linux-gnueabihf
PHONY_MAKES =
QEMU_EXE = qemu-$(ARCH)
RUN_CMD = $(QEMU_EXE) -L $(SYSROOT)
TEST = test

ifeq ($(CTNG),)
  PREFIX_PATH = $(PREFIX)
  SYSROOT = $(DEFAULT_SYSROOT)
else
  PREFIX_PATH = $(CTNG)/$(PREFIX)/bin/$(PREFIX)
  SYSROOT = $(CTNG)/$(PREFIX)/$(PREFIX)/sysroot
endif

-include params.mk

INS_NOEXT := $(basename $(wildcard *$(IN_EXT)))
OUTS := $(addsuffix $(OUT_EXT), $(INS_NOEXT))
OBJDUMPS := $(addsuffix $(OBJDUMP_EXT), $(INS_NOEXT))

.PHONY: all clean doc objdump test $(PHONY_MAKES)
.PRECIOUS: %$(OBJ_EXT)

all: $(OUTS)
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony}; \
	done

%$(OUT_EXT): %$(OBJ_EXT) $(DRIVER_OBJ)
	$(CC) $(CFLAGS) -o '$@' '$<' $(DRIVER_OBJ)

%$(OBJDUMP_EXT): %$(OUT_EXT)
	$(OBJDUMP) -S '$<' > '$@'

%$(OBJ_EXT): %$(IN_EXT) common.h
	$(CC) $(CFLAGS) -c -o '$@' '$<'

$(DRIVER_OBJ): $(DRIVER_BASENAME).c
	$(CC) $(CFLAGS) -c -o '$@' '$<'

clean:
	rm -f *.html *.o *.objdump *.out
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony} clean; \
	done

doc: README.html

README.html: README.adoc
	asciidoctor -b html5 -v '$<' > '$@'

gdb-%: %$(OUT_EXT)
	$(RUN_CMD) -g $(GDB_PORT) '$<' &
	gdb-multiarch -q \
	  -nh \
	  -ex 'set confirm off'  \
	  -ex 'set architecture $(ARCH)' \
	  -ex 'set sysroot $(SYSROOT)' \
	  -ex 'file $<' \
	  -ex 'target remote localhost:$(GDB_PORT)' \
	  -ex 'break asm_main_end' \
	  -ex 'continue' \
	  -ex 'layout split' \
	;

objdump: $(OBJDUMPS)
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony} objdump; \
	done

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
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony} test; \
	done
