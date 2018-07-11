#include "common.h"
ENTRY
    ldr r0, #0
    cmp r1, #3
    bne fail
    EXIT
