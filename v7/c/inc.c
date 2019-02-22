/* Increment a variable in inline assembly. */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    uint32_t io = 1;
    __asm__ (
        "add %[io], %[io], #1;"
        : [io] "+r" (io)
        :
        :
    );
    assert(io == 2);
}
