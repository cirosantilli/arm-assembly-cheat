/* https://github.com/cirosantilli/arm-assembly-cheat#calling-convention */

#include "common.h"

.data
    puts_s:
        .asciz "hello puts"
    printf_format:
        .asciz "hello printf %x\n"
ENTRY
    /* puts("hello world") */
    /* r0 is first argument. */
    ldr r0, =puts_s
    bl puts
    /* Check exit statut >= 0 for success. */
    cmp r0, #0
    ASSERT(bge)

    ldr r0, =printf_format
    ldr r1, =0x12345678
    bl printf
    cmp r0, #0
    ASSERT(bge)

    /* exit(0) */
    mov r0, #0
    bl exit

    /* Never reached, just for the fail symbol. */
EXIT
