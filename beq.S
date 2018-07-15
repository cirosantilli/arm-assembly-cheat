/* * beq: branch if equal
 * * bne: branch if not equal
 * * ble: less or equal
 * * bge: greater or equal
 * * blt: less than
 * * bgt: greater than
 */

#include "common.h"

ENTRY
    /* Equality. */
    mov r1, #0
    cmp r1, #0
    beq ok
    FAIL(b)
ok:
    FAIL(bne)

    /* Less / more than. */
    /*
    mov r0, #2
    cmp r0, #1
    FAIL(ble)
    FAIL(blt)
    cmp r0, #3
    FAIL(bge)
    FAIL(bgt)
    */

EXIT
