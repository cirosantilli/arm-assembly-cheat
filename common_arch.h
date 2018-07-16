#ifndef COMMON_ARCH_H
#define COMMON_ARCH_H

/* Store all callee saved registers, and LR in case we make further BL calls.
 *
 * Also save the input arguments r0-r3 on the stack, so we can access them later on,
 * despite those registers being overwritten.
 */
#define ENTRY \
.text; \
.global asm_main; \
asm_main: \
    stmdb sp!, { r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, lr }; \
asm_main_end: \
;

/* Meant to be called at the end of ENTRY.*
 *
 * Branching to "fail" makes tests fail with exit status 1.
 *
 * If EXIT is reached, the program ends successfully.
 *
 * Restore LR and bx jump to it to return from asm_main.
 */
#define EXIT \
    mov r0, #0; \
    mov r1, #0; \
    b pass; \
fail: \
    ldr r1, [sp]; \
    str r0, [r1]; \
    mov r0, #1; \
pass: \
    add sp, #16; \
    ldmia sp!, { r4, r5, r6, r7, r8, r9, r10, r11, lr }; \
    bx lr; \
;

#define FAIL_IF(condition) \
    condition 1f; \
    b 2f; \
1: \
    ldr r0, =__LINE__; \
    b fail; \
2: \
;

#endif
