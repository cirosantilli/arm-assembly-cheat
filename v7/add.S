#include "common.h"

ENTRY

    /* Immediate encoding.
     *
     * r1 = r0 + 2
     */
    mov r0, #1
    /* r1 = r0 + 2 */
    add r1, r0, #2
    cmp r1, #3
    ASSERT(beq)

    /* If src == dest, we can omit one of them.
     *
     * r0 = r0 + 2
     */
    mov r0, #1
    add r0, #2
    cmp r0, #3
    ASSERT(beq)

    /* Register encoding.
     *
     * r2 = r0 + r1
     */
    mov r0, #1
    mov r1, #2
    add r2, r0, r1
    cmp r1, #3

    /* Register encoding, omit implicit register.
     *
     * r1 = r1 + r0
     */
    mov r0, #1
    mov r1, #2
    add r1, r0
    cmp r1, #3
    ASSERT(beq)

EXIT
