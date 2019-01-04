/* https://github.com/cirosantilli/arm-assembly-cheat#data-processing-instructions */

#include "common.h"

ENTRY

    /* Immediate encoding.
     *
     * r1 = r0 + 2
     */
    mov r0, #1
    /* r1 = r0 + 2 */
    add r1, r0, #2
    ASSERT_EQ(r1, 3)

    /* If src == dest, we can omit one of them.
     *
     * r0 = r0 + 2
     */
    mov r0, #1
    add r0, #2
    ASSERT_EQ(r0, 3)

    /* Register encoding.
     *
     * r2 = r0 + r1
     */
    mov r0, #1
    mov r1, #2
    add r2, r0, r1
    ASSERT_EQ(r2, 3)

    /* Register encoding, omit implicit register.
     *
     * r1 = r1 + r0
     */
    mov r0, #1
    mov r1, #2
    add r1, r0
    ASSERT_EQ(r1, 3)

EXIT
