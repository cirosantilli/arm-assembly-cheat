/* Bitwise AND. */

#include "common.h"

ENTRY
    mov r0, #77
    mov r1, #5

    and r2, r1, #0
    cmp r2, #0
    ASSERT(beq)

    and r2, r1, #1
    cmp r2, #1
    ASSERT(beq)

    and r2, r1, #4
    cmp r2, #4
    ASSERT(beq)

    and r2, r1, #0xFF
    cmp r2, #5
    ASSERT(beq)

EXIT
