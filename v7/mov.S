/* https://github.com/cirosantilli/arm-assembly-cheat#mov */

#include "common.h"

ENTRY

    /* Immediate. */
    mov r0, #0
    cmp r0, #0
    ASSERT(beq)
    mov r0, #1
    cmp r0, #1
    ASSERT(beq)

    /* Register. */
    mov r0, #0
    mov r1, #1
    mov r1, r0
    cmp r1, #0
    ASSERT(beq)

EXIT
