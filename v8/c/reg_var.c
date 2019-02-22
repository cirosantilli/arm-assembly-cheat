/* https://gcc.gnu.org/onlinedocs/gcc-4.4.2/gcc/Explicit-Reg-Vars.html */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    register uint32_t x0 __asm__ ("x0");
    __asm__ ("mov x0, 1;" : : : "x0");
    assert(x0 == 1);
    __asm__ ("add x0, x0, 1;" : : : "x0");
    assert(x0 == 2);
}
