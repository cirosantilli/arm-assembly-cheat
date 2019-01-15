/* https://github.com/cirosantilli/arm-assembly-cheat#registers */

#include "common.h"

ENTRY
#if 0
    /* Unlike v7, we can't use PC like any other register in ARMv8,
     * since it is not a general purpose register anymore.
     *
     * Only branch instructions can modify the PC.
     *
     * B1.2.1 "Registers in AArch64 state" says:
     *
     * Software cannot write directly to the PC. It
     * can only be updated on a branch, exception entry or
     * exception return.
     */
    ldr pc, =10f
    FAIL
10:
#endif
#if 0
    mov x0, pc
#endif
EXIT
