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
    b fail
ok:
    bne fail

    /* Less / more than. */
    mov r0, #2
    cmp r0, #1
    ble fail
    blt fail
    cmp r0, #3
    bge fail
    bgt fail

    EXIT
