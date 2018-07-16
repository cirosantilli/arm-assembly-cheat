#include "common.h"

ENTRY

    /* 1 + 2 = 3, immediates. */
    mov r0, #1
    /* r1 = r0 + 2 */
    add r1, r0, #2
    cmp r1, #3
    FAIL_IF(bne)

    /* If src == dest, we can ommit one of them. */
    mov r0, #1
    add r0, #2
    cmp r0, #3
    FAIL_IF(bne)

    /* 1 + 2 = 3, register. */
    mov r0, #1
    mov r1, #2
    add r1, r0
    cmp r1, #3
    FAIL_IF(bne)

EXIT
