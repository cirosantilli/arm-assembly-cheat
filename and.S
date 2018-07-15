/* Bitwise AND. */

#include "common.h"

ENTRY
    mov r0, #77
    mov r1, #5

    and r2, r1, #0
    cmp r2, #0
    bne fail

    and r2, r1, #1
    cmp r2, #1
    bne fail

    and r2, r1, #4
    cmp r2, #4
    bne fail

    and r2, r1, #0xFF
    cmp r2, #5
    bne fail

EXIT
