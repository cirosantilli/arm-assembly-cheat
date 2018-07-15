.extern exit, printf, puts

/* Store all callee saved registers, and lr in case we make further BL calls. */
#define ENTRY \
.text; \
.global asm_main; \
asm_main: \
    stmdb sp!, { r4, r5, r6, r7, r8, r9, r10, r11, lr }

/* Branching to "fail" makes tests fail with exit status 1.
 *
 * If EXIT is reached, the program ends successfully.
 *
 * Meant to be called at the end of ENTRY.
 *
 * Restore lr and jump to it to return from asm_main.
 */
#define EXIT \
	mov r0, #0; \
	b pass; \
fail: \
	mov r0, #1; \
pass: \
	ldmia sp!, { r4, r5, r6, r7, r8, r9, r10, r11, lr }; \
	bx lr
