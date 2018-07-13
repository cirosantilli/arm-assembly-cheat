/* Store values from memory into registers. */

#include "common.h"

ENTRY
    /* Cannot use PC relative addressing, or else it fails with:
     *
     * ....
     * Error: internal_relocation (type: OFFSET_IMM) not fixed up
     * ....
     */
    /*ldr r0, myvar*/

    # r0 will contain the address.
    ldr r0, =myvar

    # Sanity check.
    ldr r1, r0
    movw r2, #0x5678
    movt r2, #0x1234
    cmp r1, r2

    ## Modify the value.
    #movw r1, #0xDEF0
    #movt r1, #0x9ABC
    #str r0, myvar

    ## Check that it changed.
    #ldr r0, myvar
    #movw r1, #0xDEF0
    #movt r1, #0x9ABC
    #cmp r0, r1
    #bne fail

    EXIT
.data;
/* Must be in the .data section, since we want to modify it. */
myvar:
    .word 0x12345678
