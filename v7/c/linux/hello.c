/* Linux C inline assembly hello world:
 *
 * * https://stackoverflow.com/questions/10831792/how-to-use-specific-register-in-arm-inline-assembler
 * * https://stackoverflow.com/questions/3929442/how-to-specify-an-individual-register-as-constraint-in-arm-gcc-inline-assembly dupe
 * * https://stackoverflow.com/questions/21729497/doing-a-syscall-without-libc-using-arm-inline-assembly
 */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    /* write */
    char msg[] = "hello syscall v7\n";
    __asm__ (
        "mov r0, #1;" /* stdout */
        "mov r1, %[msg];"
        "mov r2, %[len];"
        "mov r7, #4;" /* syscall number */
        "svc #0;"
        :
        : [msg] "r" (&msg),
          [len] "i" (sizeof(msg))
        : "r0", "r1", "r2", "r7"
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
