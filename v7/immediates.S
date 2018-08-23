/* https://github.com/cirosantilli/arm-assembly-cheat#immediates */

#include "common.h"
ENTRY
   /* These fail. */
#if 0
    mov r0, 1
    mov r0, 0x1
#endif
    mov r0, #1
    mov r0, #0x1
    mov r0, $1
    mov r0, $0x1
.syntax unified
    mov r0, 1
    mov r0, 0x1
    mov r0, #1
    mov r0, #0x1
    mov r0, $1
    mov r0, $0x1
.syntax divided
EXIT
