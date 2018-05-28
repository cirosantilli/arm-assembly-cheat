.POSIX:

CCC ?= arm-linux-gnueabihf-gcc -ggdb3 -Wall -Wextra -pedantic -marm #-mthumb
DRIVER_BASENAME ?= main
IN_EXT ?= .S
OBJ_EXT ?= .o
OUT_EXT ?= .out
RUN_CMD ?= qemu-arm -L /usr/arm-linux-gnueabihf
RUN ?= hello_driver
TEST ?= test
DRIVER_OBJ ?= $(DRIVER_BASENAME)$(OBJ_EXT)

OUTS := $(addsuffix $(OUT_EXT), $(basename $(wildcard *$(IN_EXT))))

.PHONY: all clean test
.PRECIOUS: %$(OBJ_EXT)

all: $(OUTS) hello_c$(OUT_EXT)

hello_c$(OUT_EXT): hello_c.c
	$(CCC) -o '$@' '$<'

%$(OUT_EXT): %$(OBJ_EXT) $(DRIVER_OBJ)
	$(CCC) -o '$@' '$<' $(DRIVER_OBJ)

%$(OBJ_EXT): %$(IN_EXT) common.h
	$(CCC) -c -o '$@' '$<'

$(DRIVER_OBJ): $(DRIVER_BASENAME).c
	$(CCC) -c -o '$@' '$<'

clean:
	rm -f *.o *.out

debug-%: %$(OUT_EXT)
	$(RUN_CMD) -g 1234 '$<' &
	gdb-multiarch -q \
	  -ex 'set architecture arm' \
	  -ex 'file $<' \
	  -ex 'target remote localhost:1234' \
	  -ex 'break asm_main' \
	  -ex 'continue' \

run-%: %$(OUT_EXT)
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
