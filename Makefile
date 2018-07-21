.POSIX:

CC = $(PREFIX_PATH)gcc
CFLAGS = -ggdb3 -march=$(MARCH) -pedantic -std=c99 -Wall -Wextra $(CFLAGS_QEMU) $(CFLAGS_EXTRA)
# no-pie: https://stackoverflow.com/questions/51310756/how-to-gdb-step-debug-a-dynamically-linked-executable-in-qemu-user-mode
# And the flag not present in Raspbian 2017 which has an ancient gcc 4.9, so we have to remove it.
CFLAGS_QEMU = -fno-pie -no-pie
CTNG =
DEFAULT_SYSROOT = /usr/$(PREFIX)
DRIVER_BASENAME = main
DRIVER_OBJ = $(DRIVER_BASENAME)$(OBJ_EXT)
GDB_BREAK = asm_main_end
GDB_PORT = 1234
IN_EXT = .S
NATIVE =
OBJDUMP = $(PREFIX_PATH)objdump
OBJDUMP_EXT = .objdump
OBJ_EXT = .o
OUT_EXT = .out
PHONY_MAKES =
ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
QEMU_DIR = $(ROOT_DIR)/qemu
QEMU_EXE = $(QEMU_OUT_DIR)/$(ARCH)-linux-user/qemu-$(ARCH)
QEMU_OUT_DIR = $(ROOT_DIR)/out/qemu/$(ARCH)
RUN_CMD = $(QEMU_EXE) -L $(SYSROOT)
TEST = test

ifeq ($(CTNG),)
  PREFIX_PATH = $(PREFIX)-
  SYSROOT = $(DEFAULT_SYSROOT)
else
  PREFIX_PATH = $(CTNG)/$(PREFIX)/bin/$(PREFIX)-
  SYSROOT = $(CTNG)/$(PREFIX)/$(PREFIX)/sysroot
endif

INS = $(wildcard *$(IN_EXT))
INS_NOEXT = $(basename $(INS))
OUTS = $(addsuffix $(OUT_EXT), $(INS_NOEXT))
OBJDUMPS = $(addsuffix $(OBJDUMP_EXT), $(INS_NOEXT))

-include params.mk

ifeq ($(NATIVE),y)
  CFLAGS_QEMU =
  PREFIX_PATH =
  QEMU_EXE =
  # TODO remove this, make Linux work.
  PHONY_MAKES =
  RUN_CMD = PATH=".:${PATH}"
endif

.PHONY: all clean doc objdump qemu qemu-clean test $(PHONY_MAKES)
.PRECIOUS: %$(OBJ_EXT)

all: $(OUTS) qemu
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

gdb-%: %$(OUT_EXT) $(QEMU_EXE)
	if [ '$(NATIVE)' = y ]; then \
	  gdb_cmd=gdb; \
	  gdb_after='-ex run'; \
	else \
	  $(RUN_CMD) -g $(GDB_PORT) '$<' & \
	  gdb_cmd="gdb-multiarch \
	-ex 'set architecture $(ARCH)' \
	-ex 'set sysroot $(SYSROOT)' \
	-ex 'target remote localhost:$(GDB_PORT)' \
	"; \
	  gdb_after='-ex continue'; \
	fi; \
	gdb_cmd="$${gdb_cmd} \
	-q \
	-nh \
	-ex 'set confirm off' \
	-ex 'file $<' \
	-ex 'break $(GDB_BREAK)' \
	-ex 'layout split' \
	$$gdb_after \
	"; \
	echo "$$gdb_cmd"; \
	eval "$$gdb_cmd"

objdump: $(OBJDUMPS)
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony} objdump; \
	done

qemu: $(QEMU_EXE)

$(QEMU_EXE):
	mkdir -p '$(QEMU_OUT_DIR)'
	cd '$(QEMU_OUT_DIR)' && \
	"$(QEMU_DIR)/configure" \
	  --enable-debug \
	  --target-list="$(ARCH)-linux-user" \
	&& \
	make -j`nproc`

qemu-clean:
	rm -rf '$(QEMU_OUT_DIR)'
	for phony in $(QEMU_PHONY_MAKES); do \
	  $(MAKE) -C $${phony} qemu-clean; \
	done

test-%: %$(OUT_EXT) $(QEMU_EXE)
	$(RUN_CMD) '$<'

test: all
	@\
	if [ -x $(TEST) ]; then \
	  ./$(TEST) '$(OUT_EXT)' ;\
	else\
	  fail=false ;\
	  for t in $(OUTS); do\
	    if ! $(RUN_CMD) "$$t"; then \
	      fail=true ;\
	      break ;\
	    fi ;\
	  done ;\
	  if $$fail; then \
	    echo "TEST FAILED: $$t" ;\
	    exit 1 ;\
	  fi ;\
	fi ;\
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony} test; \
	done; \
	echo 'ALL TESTS PASSED'
