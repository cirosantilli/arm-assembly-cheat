/* https://github.com/cirosantilli/arm-assembly-cheat#adr */

#include "common.h"

ENTRY
    adr r0, label
    /* objdump tells us that this uses the literal pool,
     * it does not get converted to adr, which is the better
     * alternative here.
     */
    ldr r1, =label
label:
    cmp r0, r1
    ASSERT(beq)
EXIT
