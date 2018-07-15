/* Mnemonics for:
 *
 * ....
 * STMDB sp!, reglist
 * LDMIA sp! reglist
 * ....
 *
 * but recommended in that case.
 *
 * http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0489e/Babefbce.html
 *
 * Both commands take a register list in AArch32, which gives great choice of what to push,
 * and is encoded on a single instruction.
 *
 * AArch64 loses those instructions, likely because it was not possible anymore to encode all registers:
 * http://stackoverflow.com/questions/27941220/push-lr-and-pop-lr-in-arm-arch64
 */

#include "common.h"

ENTRY
    /* Save sp before push. */
    mov r0, sp

    /* Push. */
    mov r1, #1
    mov r2, #2
    push {r1, r2}

    /* Save sp after push. */
    mov r1, sp

    /* Restore. */
    mov r3, #0
    mov r4, #0
    pop {r3, r4}
    cmp r3, #1
    FAIL_IF(bne)
    cmp r4, #2
    FAIL_IF(bne)

    /* Check that stack pointer moved down by 8 bytes
     * (2 registers x 4 bytes each). */
    sub r0, r1
    cmp r0, #8
    FAIL_IF(bne)

EXIT
