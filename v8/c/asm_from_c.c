/* https://github.com/cirosantilli/arm-assembly-cheat#calling-convention */

#include <assert.h>
#include <inttypes.h>

uint64_t myfunc(void);

/* { return 42; } */
__asm__(
    ".global myfunc;"
    "myfunc:"
    "mov x0, 42;"
    "ret;"
);

int main(void) {
    assert(myfunc() == 42);
}
