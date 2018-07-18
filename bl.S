/* = bl
 *
 * Branch with link.
 *
 * Major way to make function calls.
 *
 * With link means to put the return value on lr, so that function return
 * can know where to return.
 *
 * The current ARM / Thumb mode is encoded in the least significant bit of lr.
 *
 * = bx
 *
 * bx: branch and switch to ARM / thumb mode, encoded in the least significant
 * bit of the given register.
 *
 * bx lr is the main way to return from function calls.
 */

#include "common.h"

ENTRY
    mov r0, #1
    bl inc
    cmp r0, #2
    ASSERT(beq)
EXIT
inc:
    add r0, #1
    bx lr
