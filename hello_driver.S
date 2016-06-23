.text
.thumb_func
.global asm_main
asm_main:
    /* Set the return value according to the ARM calling convention. */
    /* mov %r0, $77 */
    mov %r0, $77
    bx lr
