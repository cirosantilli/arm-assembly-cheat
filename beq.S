/* * beq: branch if equal
 * * bne: branch if not equal
 * * ble: less or equal
 * * bge: greater or equal
 * * blt: less than
 * * bgt: greater than
 */

#include "common.h"

ENTRY
    /* Smaller*/
    mov r0, #1
    cmp r0, #2
    ASSERT(ble)
    ASSERT(blt)
    ASSERT(bne)

    /* Equal. */
    mov r1, #0
    cmp r1, #0
    ASSERT(beq)
    ASSERT(bge)
    ASSERT(ble)

    /* Greater. */
    mov r0, #2
    cmp r0, #1
    ASSERT(bge)
    ASSERT(bgt)
    ASSERT(bne)
EXIT
