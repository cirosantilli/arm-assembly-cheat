/* https://github.com/cirosantilli/arm-assembly-cheat#ldr-armv8 */

#include "common.h"

.data;
new:
    .skip 4
old:
    .skip 4

ENTRY
    /* These will contain the addresses. */
    ldr r0, =new
    ldr r1, =old

    /* Can load into sp. */
    str r0, [r0]
    /* Can be encoded. */
    str sp, [r1]
    /* Can be encoded. */
    ldr sp, [r0]
    add sp, #4
    ldr r2, =0x12345678
    push {r2}
    ldr sp, [r1]
    ldr r3, [r0]
    ASSERT_REG_EQ(r2, r3)

    /* Can load into pc. */
    ldr r2, =jumpto
    str r2, [r0]
    /* Can be encoded. */
    ldr pc, [r0]
    FAIL
jumpto:
    /* Can be encoded. */
    str pc, [r0]
    ldr r3, [r0]
    /* https://stackoverflow.com/questions/24091566/why-does-the-arm-pc-register-point-to-the-instruction-after-the-next-one-to-be-e */
    sub r3, #8
    ASSERT_REG_EQ(r2, r3)
EXIT
