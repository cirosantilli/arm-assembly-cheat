/* ldrh: load a Half-word (2 bytes). */

#include "common.h"

ENTRY
    ldr r0, =myvar
    mov r1, #0x0
    ldrh r1, [r0]
    ldr r2, =0x00005678
    cmp r1, r2
    ASSERT(beq)
EXIT
myvar:
    .word 0x12345678
