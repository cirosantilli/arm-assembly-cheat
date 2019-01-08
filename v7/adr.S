/* https://github.com/cirosantilli/arm-assembly-cheat#adr */

#include "common.h"

ENTRY
    adr r0, label
    /* objdump tells us that this uses the literal pool,
     * it does not get converted to adr, which is the better
     * alternative here.
     */
    adr r1, label
    adrl r2, label
label:
    ASSERT_EQ_REG(r0, r1)
    ASSERT_EQ_REG(r0, r2)
EXIT
