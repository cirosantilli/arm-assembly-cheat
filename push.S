#include "common.h"

ENTRY
    /* Save sp before push. */
    mov r0, sp

    /* Push. */
    mov r1, #1
    mov r2, #2
    push {r1, r2}

    /* Save sp after push. */
    mov r1, sp

    /* Restore. */
    mov r3, #0
    mov r4, #0
    pop {r3, r4}
    cmp r3, #1
    ASSERT(beq)
    cmp r4, #2
    ASSERT(beq)

    /* Check that stack pointer moved down by 8 bytes
     * (2 registers x 4 bytes each). */
    sub r0, r1
    cmp r0, #8
    ASSERT(beq)

EXIT
