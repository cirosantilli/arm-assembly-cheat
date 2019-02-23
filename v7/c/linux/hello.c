/* https://github.com/cirosantilli/arm-assembly-cheat#freestanding-linux-inline-assembly-system-calls */

#include <inttypes.h>

void _start(void) {
    /* write */
    char msg[] = "hello syscall v7\n";
    __asm__ (
        "mov r0, #1;" /* stdout */
        "mov r1, %[msg];"
        "mov r2, %[len];"
        "mov r7, #4;" /* syscall number */
        "svc #0;"
        :
        : [msg] "r" (msg),
          [len] "r" (sizeof(msg))
        : "r0", "r1", "r2", "r7", "memory"
    );

    /* exit */
    uint32_t exit_status = 0;
    __asm__ (
        "ldr r0, %[exit_status];"
        "mov r7, #1;" /* syscall number */
        "svc #0"
        :
        : [exit_status] "m" (exit_status)
        : "r0", "r7"
    );
}
