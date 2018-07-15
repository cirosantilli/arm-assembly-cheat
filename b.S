/* Unconditional branch. jmp in x86. */

#include "common.h"
ENTRY
    mov r0, #0
    /* Jump over the fail. */
    b ok
    FAIL_IF(b)
ok:
EXIT
