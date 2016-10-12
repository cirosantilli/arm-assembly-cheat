/*
How to call C libc from arm. TODO not working.

Equivalent to knowing the calling conventions, so we won't go into too much detail here.

http://stackoverflow.com/questions/8422287/calling-c-functions-from-arm-assembly
*/

#include "common.h"

.data
    msg:
        .asciz "hello world"
ENTRY

    /* First argument is exit status */
    ldr r0, =msg
    /* TODO segfault. Check if alignment? */
    /*bl puts*/

    /* First argument is exit status */
    mov r0, #0
    /*bl exit*/

    mov r0, #0
    bx lr
