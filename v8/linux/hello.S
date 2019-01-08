.text
.global _start
_start:
asm_main_after_prologue:
    /* write */
    mov x0, 1
    adr x1, msg
    ldr x2, =len
    mov x8, 64
    svc 0

    /* exit */
    mov x0, 0
    mov x8, 93
    svc 0
msg:
    .ascii "hello syscall v8\n"
len = . - msg
