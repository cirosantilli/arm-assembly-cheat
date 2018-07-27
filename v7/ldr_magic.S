/* https://github.com/cirosantilli/arm-assembly-cheat#ldr-magic */

#include "common.h"

ENTRY

    /* Mnemonic for a PC relative load.
     * ldr r0, [pc, #offset]
     * r0 = myvar
     */
    ldr r0, myvar
    movw r1, #0x5678
    movt r1, #0x1234
    cmp r0, r1
    ASSERT(beq)

    /* Mnemonic PC relative load with an offset.
     * Load myvar2 instead of myvar.
     */
    ldr r0, myvar + 4
    movw r1, #0xDEF0
    movt r1, #0x9ABC
    cmp r0, r1
    ASSERT(beq)

    /* r0 = &myvar
     *
     * First store the address in r0 using a magic =myvar, which creates
     * a new variable containing the address and PC-relative addresses it
     * https://stackoverflow.com/questions/17214962/what-is-the-difference-between-label-equals-sign-and-label-brackets-in-ar
     */
    ldr r0, =myvar
    ldr r1, [r0]
    movw r2, #0x5678
    movt r2, #0x1234
    cmp r1, r2
    ASSERT(beq)

    /* More efficiently, use r0 as the address to read, and write to r0 itself. */
    ldr r0, =myvar
    ldr r0, [r0]
    movw r1, #0x5678
    movt r1, #0x1234
    cmp r0, r1
    ASSERT(beq)

    /* Same as =myvar but store a constant to a register.
     * Can also be done with movw and movt. */
    ldr r0, =0x11112222
    movw r1, #0x2222
    movt r1, #0x1111
    cmp r0, r1
    ASSERT(beq)

    /* We can also use GAS tolower16 and topper16  and movw and movt
     * to load the address of myvar into r0 with two immediates.
     *
     * This results in one extra 4 byte instruction read from memory,
     * and one less data read, so it is likely more cache efficient.
     */
    movw r0, #:lower16:myvar
    movt r0, #:upper16:myvar
    ldr r1, [r0]
    movw r2, #0x5678
    movt r2, #0x1234
    cmp r1, r2
    ASSERT(beq)

EXIT
myvar:
    .word 0x12345678
myvar2:
    .word 0x9ABCDEF0
