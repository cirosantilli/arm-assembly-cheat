#include "common.h"
ENTRY

    /* Immediate. */
    mov r0, #0
    cmp r0, #0
    bne fail
    mov r0, #1
    cmp r0, #1
    bne fail

    EXIT
