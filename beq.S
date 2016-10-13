/*
# beq

Branch if equal.
*/

#include "common.h"

ENTRY
    /* Will return 0 if we don't change it. */
    mov r0, #0
    /* If this is not zero, we end up changing the return value r0.
     * Change this value to see the test fail. */
    mov r1, #0
    /*mov r1, #1*/
    /* Compare and branch if zero. */
    cmp r1, #0
    beq ok
    b fail
ok:
    EXIT
