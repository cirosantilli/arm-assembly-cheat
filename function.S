/*
TODO get working.

Simple function calls, using the standard ARM calling convention.
*/

#include "common.h"

ENTRY
    /*
    push lr
    mov r0, #1
    mov r1, #2
    bl add
    subs r0, #3
    bne r0, fail
    fail:
    mov r0, #1
    pass:
    pop lr
    */
    mov r0, #0
    bx lr
/*
.thumb_func
add:
    add r0, r1, r2
    b lr
*/
