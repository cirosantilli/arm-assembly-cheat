.data
    msg:
        .ascii "hello world\n"
    len = . - msg
.text
.global _start
_start:
    /* write syscall. */
    mov %r0, $1     /* stdout */
    ldr %r1, =msg   /* buffer */
    ldr %r2, =len   /* len */
    mov %r7, $4     /* Syscall ID. */
    swi $0

    /* exit syscall */
    mov %r0, $0 /* Status. */
    mov %r7, $1 /* Syscall ID. */
    swi $0
