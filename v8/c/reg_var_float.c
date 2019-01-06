/* https://gcc.gnu.org/onlinedocs/gcc-4.4.2/gcc/Explicit-Reg-Vars.html
 *
 * https://stackoverflow.com/questions/6514537/how-do-i-specify-immediate-floating-point-numbers-with-inline-assembly/52906126#52906126
 */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    register double d0 __asm__ ("d0");
    __asm__ ("fmov d0, 1.5" : : : "%d0");
    assert(d0 == 1.5);
    __asm__ (
        "fmov d1, 2.5;"
        "fadd d0, d0, d1"
        : : : "%d0", "%d1");
    assert(d0 == 4.0);
}
