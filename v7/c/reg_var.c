/* https://gcc.gnu.org/onlinedocs/gcc-4.4.2/gcc/Explicit-Reg-Vars.html */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    register uint32_t r0 __asm__ ("r0");
    __asm__ ("mov r0, #1;" : : : "r0");
    assert(r0 == 1);
    __asm__ ("add r0, r0, #1;" : : : "r0");
    assert(r0 == 2);
}
