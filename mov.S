/* https://github.com/cirosantilli/arm-assembly-cheat#mov */

#include "common.h"

ENTRY

    /* Immediate. */
    mov r0, #0
    cmp r0, #0
    ASSERT(beq)
    mov r0, #1
    cmp r0, #1
    ASSERT(beq)

    /* Register. */
    mov r0, #0
    mov r1, #1
    mov r1, r0
    cmp r1, #0
    ASSERT(beq)

    /* movt (top) and movw set the higher and lower 16 bits of the register. */
    movw r0, #0xFFFF
    movt r0, #0x1234
    add r0, #1
    ldr r1, =0x12350000
    cmp r0, r1
    ASSERT(beq)

    /* movt also zeroes out the top bits, allowing small 16-bit
     * C constants to be assigned in a single instruction.
     */
    ldr r0, =0x12345678
    movw r0, 0x1111
    ldr r1, =0x00001111
    cmp r0, r1
    ASSERT(beq)

EXIT
