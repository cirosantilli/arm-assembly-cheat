.POSIX:

AS = $(BINUTILS_BIN_DIR)/$(ARCH)-elf-as
ASM_EXT = .S
ASFLAGS = --gdwarf-2 -march=$(MARCH_AS) $(ASFLAGS_EXTRA)
BINUTILS_BIN_DIR = $(BINUTILS_INSTALL_DIR)/bin
CC = $(PREFIX_PATH)gcc
CFLAGS = -ggdb3 -march=$(MARCH) -pedantic -std=c99 -Wall -Wextra $(CFLAGS_QEMU) $(CFLAGS_EXTRA)
CPP = $(PREFIX_PATH)cpp
CPP_EXT = $(ASM_EXT).tmp
# no-pie: https://stackoverflow.com/questions/51310756/how-to-gdb-step-debug-a-dynamically-linked-executable-in-qemu-user-mode
# And the flag not present in Raspbian 2017 which has an ancient gcc 4.9, so we have to remove it.
CFLAGS_QEMU = -fno-pie -no-pie
COMMON_HEADER = common.h
CTNG =
C_EXT = .c
DEFAULT_SYSROOT = /usr/$(PREFIX)
DRIVER_BASENAME_NOEXT = main
DRIVER_BASENAME = main$(C_EXT)
DRIVER_OBJ = $(DRIVER_BASENAME_NOEXT)$(OBJ_EXT)
GDB_BREAK = asm_main_after_prologue
GDB = $(BINUTILS_BIN_DIR)/$(ARCH)-elf-gdb
GDB_PORT = 1234
MARCH_AS = $(MARCH)
NATIVE =
OBJDUMP = $(PREFIX_PATH)objdump
OBJDUMP_EXT = .objdump
OBJ_EXT = .o
OUT_EXT = .out
PHONY_MAKES =
ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BINUTILS_SRC_DIR = $(ROOT_DIR)/binutils-gdb
BINUTILS_OUT_DIR = $(OUT_DIR)/binutils-gdb
BINUTILS_BUILD_DIR = $(BINUTILS_OUT_DIR)/build/$(ARCH)
BINUTILS_INSTALL_DIR = $(BINUTILS_OUT_DIR)/install
QEMU_SRC_DIR = $(ROOT_DIR)/qemu
QEMU_EXE = $(QEMU_BUILD_DIR)/$(ARCH)-linux-user/qemu-$(ARCH)
OUT_DIR = $(ROOT_DIR)/out
QEMU_BUILD_DIR = $(OUT_DIR)/qemu/$(ARCH)
DOC_OUT = $(OUT_DIR)/README.html
RUN_CMD = $(QEMU_EXE) -L $(SYSROOT) -E LD_BIND_NOW=1
TEST = test

ifeq ($(CTNG),)
  PREFIX_PATH = $(PREFIX)-
  SYSROOT = $(DEFAULT_SYSROOT)
else
  PREFIX_PATH = $(CTNG)/$(PREFIX)/bin/$(PREFIX)-
  SYSROOT = $(CTNG)/$(PREFIX)/$(PREFIX)/sysroot
endif

INS_ASM = $(wildcard *$(ASM_EXT))
INS_ASM_NOEXT = $(basename $(INS_ASM))
OUTS_ASM = $(addsuffix $(OUT_EXT), $(INS_ASM_NOEXT))
INS_C = $(filter-out $(DRIVER_BASENAME), $(wildcard *$(C_EXT)))
INS_C_NOEXT = $(basename $(INS_C))
OUTS_C = $(addsuffix $(OUT_EXT), $(INS_C_NOEXT))
OBJDUMPS = $(addsuffix $(OBJDUMP_EXT), $(INS_ASM_NOEXT) $(INS_C_NOEXT))
OUTS = $(OUTS_ASM) $(OUTS_C)

-include params.mk

ifeq ($(NATIVE),y)
  CFLAGS_QEMU =
  PREFIX_PATH =
  QEMU_EXE =
  RUN_CMD = PATH=".:${PATH}"
endif

ifeq ($(FREESTAND),y)
  CFLAGS_EXTRA += -nostdlib
  DRIVER_OBJ =
  COMMON_HEADER =
endif

.PHONY: all clean doc objdump binutils-gdb binutils-gdb-clean qemu qemu-clean test $(PHONY_MAKES)
.PRECIOUS: %$(OBJ_EXT)

all: binutils-gdb $(OUTS) qemu
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony}; \
	done

%$(OUT_EXT): %$(OBJ_EXT) $(DRIVER_OBJ)
	$(CC) $(CFLAGS) -o '$@' '$<' $(DRIVER_OBJ)

%$(OBJDUMP_EXT): %$(OUT_EXT)
	$(OBJDUMP) -S '$<' > '$@'

%$(OBJ_EXT): %$(C_EXT)
	$(CC) -c $(CFLAGS) -o '$@' '$<'

%$(OBJ_EXT): %$(ASM_EXT) $(COMMON_HEADER)
	$(CPP) -o '$(basename $<)$(CPP_EXT)' '$<'
	$(AS) $(ASFLAGS) -c -o '$@' '$(basename $<)$(CPP_EXT)'

$(DRIVER_OBJ): $(DRIVER_BASENAME)
	$(CC) $(CFLAGS) -c -o '$@' '$<'

clean:
	rm -f *.html *.o *.objdump *.out *$(CPP_EXT)
	for phony in $(PHONY_MAKES); do \
	  $(MAKE) -C $${phony} clean; \
	done

doc: $(DOC_OUT)

$(DOC_OUT): README.adoc
	asciidoctor -b html5 -o '$@' -v '$<'

gdb-%: %$(OUT_EXT) $(QEMU_EXE)
	if [ '$(NATIVE)' = y ]; then \
	  gdb_cmd=gdb; \
	  gdb_after='-ex run'; \
	else \
	  $(RUN_CMD) -g $(GDB_PORT) '$<' & \
	  gdb_cmd="$(GDB) \
	-ex 'set architecture $(ARCH)' \
	-ex 'set sysroot $(SYSROOT)' \
	-ex 'target remote localhost:$(GDB_PORT)' \
	"; \
	  if [ ! '$(FREESTAND)' = y ]; then \
	    gdb_after='-ex continue'; \
	  fi; \
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
	mkdir -p '$(QEMU_BUILD_DIR)'
	cd '$(QEMU_BUILD_DIR)' && \
	"$(QEMU_SRC_DIR)/configure" \
	  --enable-debug \
	  --target-list="$(ARCH)-linux-user" \
	&& \
	make -j`nproc`

qemu-clean:
	rm -rf '$(QEMU_BUILD_DIR)'
	for phony in $(QEMU_PHONY_MAKES); do \
	  $(MAKE) -C $${phony} qemu-clean; \
	done

binutils-gdb: $(AS)

$(AS):
	mkdir -p '$(BINUTILS_BUILD_DIR)'
	cd '$(BINUTILS_BUILD_DIR)' && \
	"$(BINUTILS_SRC_DIR)/configure" \
	  --target '$(ARCH)-elf' \
	  --prefix '$(BINUTILS_INSTALL_DIR)' \
	&& \
	make -j`nproc` && \
	make -j`nproc` install

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
