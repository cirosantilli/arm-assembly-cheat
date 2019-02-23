/* https://github.com/cirosantilli/arm-assembly-cheat#freestanding-linux-inline-assembly-system-calls */

#include <inttypes.h>

void _start(void) {
    /* write */
    char msg[] = "hello syscall v8\n";
    __asm__ (
        "mov x0, 1;" /* stdout */
        "mov x1, %[msg];"
        "mov x2, %[len];"
        "mov x8, 64;" /* syscall number */
        "svc 0;"
        :
        : [msg] "r" (msg),
          [len] "r" (sizeof(msg))
        : "x0", "x1", "x2", "x8", "memory"
    );

    /* exit */
    uint32_t exit_status = 0;
    __asm__ (
        "ldr x0, %[exit_status];"
        "mov x8, 93;" /* syscall number */
        "svc 0;"
        :
        : [exit_status] "m" (exit_status)
        : "x0", "x8"
    );
}
