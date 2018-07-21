/* https://github.com/cirosantilli/arm-assembly-cheat#addressing-modes */

#include "common.h"

ENTRY
    /* Offset mode with immediate. Add 4 to the address register, which ends up
     * reading myvar2 instead of myvar.
     */
    ldr r0, =myvar
    ldr r1, [r0, #4]
    ldr r2, =0x9ABCDEF0
    cmp r1, r2
    ASSERT(beq)
    /* r0 was not modified. */
    ldr r1, =myvar
    cmp r0, r1
    ASSERT(beq)

    /* Pre-indexed mode */
    ldr r0, =myvar
    ldr r1, [r0, #4]!
    ldr r2, =0x9ABCDEF0
    cmp r1, r2
    ASSERT(beq)
    /* r0 was modified. */
    ldr r1, =myvar2
    cmp r0, r1
    ASSERT(beq)

    /* Post-indexed mode */
    ldr r0, =myvar
    ldr r1, [r0], #4
    ldr r2, =0x12345678
    cmp r1, r2
    ASSERT(beq)
    /* r0 was modified. */
    ldr r1, =myvar2
    cmp r0, r1
    ASSERT(beq)

    /* Offset in register. */
    ldr r0, =myvar
    mov r1, #4
    ldr r2, [r0, r1]
    ldr r3, =0x9ABCDEF0
    cmp r2, r3
    ASSERT(beq)

    /* Offset in shifted register: 2 << 1 = 4. */
    ldr r0, =myvar
    mov r1, #2
    ldr r2, [r0, r1, LSL #1]
    ldr r3, =0x9ABCDEF0
    cmp r2, r3
    ASSERT(beq)

EXIT
myvar:
    .word 0x12345678
myvar2:
    .word 0x9ABCDEF0
