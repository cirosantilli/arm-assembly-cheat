/* https://github.com/cirosantilli/arm-assembly-cheat#calling-convention */

#include "common.h"

.data
    msg:
        .asciz "hello world"
ENTRY
    /* puts("hello world") */
    /* r0 is first argument. */
    ldr r0, =msg
    bl puts
    /* Check exit statut >= 0 for success. */
    cmp r0, #0
    blt fail

    /* exit(0) */
    mov r0, #0
    bl exit

    /* Never reached, just for the fail symbol. */
    EXIT
