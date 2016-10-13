/* 1 + 2 = 3 */

#include "common.h"

ENTRY
    mov r0, #0
    mov r1, #1
    add r1, #2
    cmp r1, #3
    bne fail
    EXIT
