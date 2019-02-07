.POSIX:

AS = $(BINUTILS_BIN_DIR)/$(ARCH)-elf-as
AS_TARGET = $(AS)
ASM_EXT = .S
ASFLAGS = --gdwarf-2 -march=$(MARCH_AS) $(ASFLAGS_EXTRA)
BINUTILS_BIN_DIR = $(BINUTILS_INSTALL_DIR)/bin
CC = $(PREFIX_PATH)gcc
CXX = $(PREFIX_PATH)g++
CFLAGS = -std=c99 $(CCFLAGS)
CCFLAGS = -ggdb3 -march=$(MARCH) -pedantic -Wall -Wextra $(CCFLAGS_QEMU) $(CCFLAGS_EXTRA) $(CCFLAGS_CLI)
CXXFLAGS = -std=c++11 $(CCFLAGS)
CPP = $(PREFIX_PATH)cpp
CPP_EXT = $(ASM_EXT).tmp
# no-pie: https://stackoverflow.com/questions/51310756/how-to-gdb-step-debug-a-dynamically-linked-executable-in-qemu-user-mode
# And the flag not present in Raspbian 2017 which has an ancient gcc 4.9, so we have to remove it.
CCFLAGS_QEMU = -fno-pie -no-pie
COMMON_HEADER = common.h
CTNG =
C_EXT = .c
CXX_EXT = .cpp
DEFAULT_SYSROOT = /usr/$(PREFIX)
DRIVER_BASENAME_NOEXT = main
DRIVER_BASENAME = main$(C_EXT)
DRIVER_OBJ = $(DRIVER_BASENAME_NOEXT)$(OBJ_EXT)
GDB = $(BINUTILS_BIN_DIR)/$(ARCH)-elf-gdb
GDB_BREAK = asm_main_after_prologue
GDB_EXPERT =
GDB_PORT = 1234
MARCH_AS = $(MARCH)
NATIVE =
OBJDUMP = $(PREFIX_PATH)objdump
OBJDUMP_EXT = .objdump
OBJ_EXT = .o
OUT_EXT = .out
RECURSE =
ROOT_DIR = $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
BINUTILS_SRC_DIR = $(ROOT_DIR)/binutils-gdb
BINUTILS_OUT_DIR = $(OUT_DIR)/binutils-gdb
BINUTILS_BUILD_DIR = $(BINUTILS_OUT_DIR)/build/$(ARCH)
BINUTILS_GDB_TARGET = binutils-gdb
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
INS_CXX = $(filter-out $(DRIVER_BASENAME), $(wildcard *$(CXX_EXT)))
INS_CXX_NOEXT = $(basename $(INS_CXX))
OUTS_CXX = $(addsuffix $(OUT_EXT), $(INS_CXX_NOEXT))
OBJDUMPS = $(addsuffix $(OBJDUMP_EXT), $(INS_ASM_NOEXT) $(INS_C_NOEXT))
OUTS = $(OUTS_ASM) $(OUTS_C) $(OUTS_CXX)
TESTS = $(filter-out $(addsuffix $(OUT_EXT), $(SKIP_TESTS)),$(OUTS))

-include params.mk
-include params_private.mk

ifeq ($(NATIVE),y)
  AS = as
  AS_TARGET =
  CCFLAGS_QEMU =
  PREFIX_PATH =
  QEMU_EXE =
  RUN_CMD = PATH=".:${PATH}"
endif

ifeq ($(FREESTAND),y)
  CCFLAGS_EXTRA += -nostdlib
  DRIVER_OBJ =
  COMMON_HEADER =
endif

.PHONY: all clean doc objdump $(BINUTILS_GDB_TARGET) binutils-gdb-clean qemu qemu-clean test $(RECURSE)
.PRECIOUS: %$(OBJ_EXT)

all: $(BINUTILS_GDB_TARGET) $(OUTS) qemu
	for phony in $(RECURSE); do \
	  $(MAKE) -C $${phony}; \
	done

%$(OUT_EXT): %$(OBJ_EXT) $(DRIVER_OBJ)
	$(CC) $(CFLAGS) -o '$@' '$<' $(DRIVER_OBJ)

%$(OBJDUMP_EXT): %$(OUT_EXT)
	$(OBJDUMP) -S '$<' > '$@'

%$(OBJ_EXT): %$(C_EXT)
	$(CC) -c $(CFLAGS) -o '$@' '$<'

%$(OBJ_EXT): %$(CXX_EXT)
	$(CXX) -c $(CXXFLAGS) -o '$@' '$<'

%$(OBJ_EXT): %$(ASM_EXT) $(COMMON_HEADER)
	$(CPP) -o '$(basename $<)$(CPP_EXT)' '$<'
	$(AS) $(ASFLAGS) -c -o '$@' '$(basename $<)$(CPP_EXT)'

$(DRIVER_OBJ): $(DRIVER_BASENAME)
	$(CC) $(CFLAGS) -c -o '$@' '$<'

clean:
	rm -f *.html *.o *.objdump *.out *$(CPP_EXT)
	for phony in $(RECURSE); do \
	  $(MAKE) -C $${phony} clean; \
	done

doc: $(DOC_OUT)

$(DOC_OUT): README.adoc
	asciidoctor -b html5 -o '$@' -v '$<'

gdb-%: %$(OUT_EXT) $(QEMU_EXE)
	if [ '$(NATIVE)' = y ]; then \
	  gdb_exe=gdb; \
	  gdb_after='-ex run'; \
	  gdb_args=; \
	else \
	  $(RUN_CMD) -g $(GDB_PORT) '$<' & \
	  gdb_exe='$(GDB)' \
	  gdb_args="\
	-ex 'set architecture $(ARCH)' \
	-ex 'set sysroot $(SYSROOT)' \
	-ex 'target remote localhost:$(GDB_PORT)' \
	"; \
	  if [ ! '$(FREESTAND)' = y ]; then \
	    gdb_after='-ex continue'; \
	  fi; \
	fi; \
	if [ ! '$(GDB_EXPERT)' = y ]; then \
	  gdb_args="$${gdb_args} \
	-nh \
	-ex 'set confirm off' \
	-ex 'layout split' \
	"; \
	fi; \
	gdb_cmd="$${gdb_exe} \
	-q \
	-ex 'file $<' \
	$${gdb_args} \
	-ex 'break $(GDB_BREAK)' \
	$$gdb_after \
	"; \
	echo "$$gdb_cmd"; \
	eval "$$gdb_cmd"

objdump: $(OBJDUMPS)
	for phony in $(RECURSE); do \
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
	for phony in $(QEMU_RECURSE); do \
	  $(MAKE) -C $${phony} qemu-clean; \
	done

binutils-gdb: $(AS_TARGET)

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
	  for t in $(TESTS); do\
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
	for phony in $(RECURSE); do \
	  $(MAKE) -C $${phony} test; \
	done; \
	echo 'ALL TESTS PASSED'
