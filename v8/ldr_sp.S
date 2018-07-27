/* https://github.com/cirosantilli/arm-assembly-cheat#ldr-armv8 */

#include "common.h"

.data;
myvar:
    .skip 4

ENTRY
    /* Enable any of the lines below to see it fail. */
#if 0
    ldr sp, [r0]
    str sp, [r0]
    ldr pc, [r0]
    str pc, [r0]
#endif
EXIT
