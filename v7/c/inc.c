/* Increment a variable in inline assembly. */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    uint32_t io = 0;
    __asm__ (
        "add %0, %0, #1;"
        : "+r" (io)
        :
        :
    );
    assert(io == 1);
}
