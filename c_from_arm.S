/*
How to call C libc from arm.

Equivalent to knowing the calling conventions.

http://stackoverflow.com/questions/8422287/calling-c-functions-from-arm-assembly

Don't forget that stack must be 8 byte aligned.
*/

#include "common.h"

.data
    msg:
        .asciz "hello world"
ENTRY
    /* r0 is first argument. */
    ldr r0, =msg
    bl puts
    /* Check exit statut >= 0 for success. */
    cmp r0, #0
    blt fail

    mov r0, #0
    bl exit

    EXIT
