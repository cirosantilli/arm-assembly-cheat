/* https://github.com/cirosantilli/arm-assembly-cheat#bl */

#include "common.h"

ENTRY
    mov r0, #1
    bl inc
    cmp r0, #2
    ASSERT(beq)
EXIT
inc:
    add r0, #1
    bx lr
