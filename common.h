.extern exit, puts

#define ENTRY \
    .text; \
    .global asm_main; \
    asm_main: \
    push {lr}

/* Branching to "fail" makes tests fail. */
#define EXIT \
        mov r0, #0; \
        b pass; \
    fail: \
        mov r0, #77; \
    pass: \
        pop {lr}; \
        bx lr;
