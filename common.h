.extern exit, puts

#define ENTRY \
    .text; \
    .global asm_main; \
    asm_main: \
    push {ip, lr} /* push ip to have 8 bytes and keep AAPCS stack alignment */

/*
Branching to "fail" makes tests fail.

r0 is ignored. If EXIT is reached, the program ends successfully.

Meant to be called at the end of ENTRY.
*/
#define EXIT \
        mov r0, #0; \
        b pass; \
    fail: \
        mov r0, #77; \
    pass: \
        pop {ip, lr}; \
        bx lr;
