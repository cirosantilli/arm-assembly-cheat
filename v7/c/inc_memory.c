/* Like inc.c but less good, just to test out
 * the "m" memory constraint.
 */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    uint32_t io = 1;
    __asm__ (
        "ldr r0, %0;"
        "add r0, r0, #1;"
        "str r0, %0;"
        : "+m" (io)
        :
        : "r0"
    );
    assert(io == 2);
}
