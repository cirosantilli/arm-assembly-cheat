/* Multiplication. */

#include "common.h"

ENTRY
    /* 2 * 3 = 6 */
    mov r0, #0
    mov r1, #2
    mov r2, #3
    mul r1, r1, r2
    cmp r1, #6
    FAIL_IF(bne)
EXIT
