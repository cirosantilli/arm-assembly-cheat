/* ldrb: load a single Byte. */

#include "common.h"

ENTRY
    ldr r0, =myvar
    mov r1, #0x0
    ldrb r1, [r0]
    ldr r2, =0x00000078
    cmp r1, r2
    ASSERT(beq)
EXIT
myvar:
    .word 0x12345678
