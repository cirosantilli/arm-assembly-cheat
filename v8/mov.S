/* Move an immediate to a register, or a register to another register.
 *
 * Cannot access memory, only ldr and str can do that.
 */

#include "common.h"

ENTRY

    #/* Immediate. */
    #mov r0, #0
    #cmp r0, #0
    #FAIL_IF(bne)
    #mov r0, #1
    #cmp r0, #1
    #FAIL_IF(bne)

    #/* Register. */
    #mov r0, #0
    #mov r1, #1
    #mov r1, r0
    #cmp r1, #0
    #FAIL_IF(bne)

EXIT
