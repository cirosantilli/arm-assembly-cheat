/* Bitwise Bit Clear: clear some bits.
 *
 * dest = `left & ~right`
 */

#include "common.h"

ENTRY
    /* 0x0F & ~0x55 == 0x05 */
    mov r0, #0x0F
    bic r0, #0x55
    cmp r0, #0x0A
    ASSERT(beq)
EXIT
