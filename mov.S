/* Move an immediate to a register, or a register to another register.
 *
 * Cannot access memory, only ldr and str can do that.
 */

#include "common.h"

ENTRY

    /* Immediate. */
    mov r0, #0
    cmp r0, #0
    FAIL_IF(bne)
    mov r0, #1
    cmp r0, #1
    FAIL_IF(bne)

    /* Register. */
    mov r0, #0
    mov r1, #1
    mov r1, r0
    cmp r1, #0
    FAIL_IF(bne)

    /* movt (top) and movw set the higher and lower 16 bits of the register. */
    movw r0, #0xFFFF
    movt r0, #0x1234
    add r0, #1
    ldr r1, =0x12350000
    cmp r0, r1
    FAIL_IF(bne)

    /* movt also zeroes out the top bits, allowing small 16-bit
     * C constants to be assigned in a single instruction.
     */
    ldr r0, =0x12345678
    movw r0, 0x1111
    ldr r1, =0x00001111
    cmp r0, r1
    FAIL_IF(bne)

EXIT
