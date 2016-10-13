/* Unconditional branch. jmp in x86. */

#include "common.h"

ENTRY
    mov r0, #0
    /* If we comment this out, the test fails. */
    b ok
    b fail
ok:
    EXIT
