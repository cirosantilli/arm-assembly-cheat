/* https://github.com/cirosantilli/arm-assembly-cheat#loop-over-array */

#include "common.h"

#define NELEM #4
#define ELEM_SIZE #4

.data;
my_array:
    .word 0x11111111, 0x22222222, 0x33333333, 0x44444444
my_array_expect:
    .word 0x11111112, 0x22222223, 0x33333334, 0x44444445

ENTRY
    /* Verify the increment. */
    ldr r0, =my_array
    mov r1, NELEM
increment:
    ldr r2, [r0]
    add r2, #1
    /* Post index usage. */
    str r2, [r0], ELEM_SIZE
    sub r1, #1
    cmp r1, #0
    bne increment

    /* Verify the increment. */
    ldr r0, =my_array
    ldr r1, =my_array_expect
    mov r2, NELEM
verify:
    /* Post index usages. */
    ldr r3, [r0], ELEM_SIZE
    ldr r4, [r1], ELEM_SIZE
    cmp r3, r4
    ASSERT(beq)
    sub r2, #1
    cmp r2, #0
    bne verify

EXIT
