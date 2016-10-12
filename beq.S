/*
# beq

Branch if equal.
*/

#include "common.h"

ENTRY
    /* Will return 0 if we don't change it. */
    mov r0, #0

    /* If this is not zero, we end up changing the return value r0.
     * Try changing it and see the test fail. */
    mov r1, #0
    /*mov r1, #1*/

    /* Compare and branch if zero. */
    cmp r1, #0
    beq 1f

    /* Change the return and make it fail. */
    mov r0, #77

    1:
    bx lr
