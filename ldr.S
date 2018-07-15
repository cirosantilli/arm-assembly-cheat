/* Load values from memory into registers. */

#include "common.h"

ENTRY
    /* PC relative load.
     * ldr r0, [pc, #offset]
     */
    ldr r0, myvar
    movw r1, #0x5678
    movt r1, #0x1234
    cmp r0, r1
    FAIL_IF(bne)

    /* PC relative load with an offset.
     * Load myvar2 instead of myvar.
     */
    ldr r0, myvar + 4
    movw r1, #0xDEF0
    movt r1, #0x9ABC
    cmp r0, r1
    FAIL_IF(bne)

    /* Read from address in a the r0 register.
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
    FAIL_IF(bne)

    /* Same as =myvar but with a constant. */
    ldr r0, =0x11112222
    movw r1, #0x2222
    movt r1, #0x1111
    cmp r0, r1
    FAIL_IF(bne)

    /* More efficiently, use r0 as the address to read, and write to r0 itself. */
    ldr r0, =myvar
    ldr r0, [r0]
    movw r1, #0x5678
    movt r1, #0x1234
    cmp r0, r1
    FAIL_IF(bne)

    /* Read from address in a the r0 register.
     *
     * Use GAS tolower16 and topper16 to load the address of myvar
     * into r0 with two immediates.
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
    FAIL_IF(bne)

    /* Read from address from the r0 register and add an offset of 4 to it,
     * which ends up reading myvar2 instead of myvar.
     */
    movw r0, #:lower16:myvar
    movt r0, #:upper16:myvar
    ldr r1, [r0, #4]
    movw r2, #0xDEF0
    movt r2, #0x9ABC
    cmp r1, r2
    FAIL_IF(bne)

EXIT
myvar:
    .word 0x12345678
myvar2:
    .word 0x9ABCDEF0
