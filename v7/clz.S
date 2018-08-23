/* https://github.com/cirosantilli/arm-assembly-cheat#data-processing-instructions */

#include "common.h"

ENTRY
    ldr r0, =0x7FFFFFFF
    clz r1, r0
    ldr r2, =1
    cmp r1, r2
    ASSERT(beq)

    ldr r0, =0x3FFFFFFF
    clz r1, r0
    ldr r2, =2
    cmp r1, r2
    ASSERT(beq)

    ldr r0, =0x1FFFFFFF
    clz r1, r0
    ldr r2, =3
    cmp r1, r2
    ASSERT(beq)
EXIT
