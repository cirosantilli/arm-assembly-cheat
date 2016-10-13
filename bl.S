/*
# bl

bl: branch and put the return value on lr.

Major way to make function calls.

The current ARM / Thumb mode is encoded in the least significant bit of lr.

# bx

bx: branch and switch to ARM / thumb mode, encoded in the least significant bit of the given register.

bx lr is the main way to return from function calls.
*/

#include "common.h"

ENTRY
    mov r0, #1
    bl inc
    cmp r0, #2
    bne fail
    EXIT

inc:
    add r0, #1
    bx lr
