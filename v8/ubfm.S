/* https://github.com/cirosantilli/arm-assembly-cheat#ubfm */

#include "common.h"

ENTRY
    ldr x0, =0x1122334455667788

    ubfm x1, x0, #8, #16
    ldr x2, =0x0000000000000077
    cmp x1, x2
    ASSERT(beq)

    ubfm x1, x0, #8, #32
    ldr x2, =0x0000000000556677
    cmp x1, x2
    ASSERT(beq)

    ubfm x1, x0, #8, #48
    ldr x2, =0x0000003344556677
    cmp x1, x2
    ASSERT(beq)

    ubfm x1, x0, #4, #16
    ldr x2, =0x0000000000000778
    cmp x1, x2
    ASSERT(beq)

    ubfm x1, x0, #4, #32
    ldr x2, =0x0000000005566778
    cmp x1, x2
    ASSERT(beq)

    ubfx x1, x0, #8, #16
    ldr x2, =0x0000000000006677
    cmp x1, x2
    ASSERT(beq)

EXIT
