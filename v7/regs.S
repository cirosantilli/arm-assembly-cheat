/* https://github.com/cirosantilli/arm-assembly-cheat#registers */

#include "common.h"

ENTRY

    /* 13 general purpose registers. */
    mov r0, 0
    mov r1, 1
    mov r2, 2
    mov r3, 3
    mov r4, 4
    mov r5, 5
    mov r6, 6
    mov r7, 7
    mov r8, 8
    mov r9, 9
    mov r10, 10
    mov r11, 11
    mov r12, 12

    /* r13: aliased to SP (stack pointer)
     * r14: aliased to LR (link register)
     * r15: aliased to PC
     *
     * In ARMv8, SP and PC have dedicated registers in addition to
     * the 32-general purpose ones.
     */
    ldr r15, =10f
    FAIL
10:

    /* It is possible to ldr into pc, and it works just like for any other register.
     *
     * This is very similar to what B does, except that B only works with constants.
     */
    ldr pc, =10f
    FAIL
10:

EXIT
