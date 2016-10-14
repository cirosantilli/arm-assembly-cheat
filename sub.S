/*
# sub

Subtraction.
*/

#include "common.h"

ENTRY
    /* 3 - 2 == 1 , register version.*/
    mov r0, #3
    mov r1, #2
    sub r0, r1
    cmp r0, #1
    bne fail
    EXIT
