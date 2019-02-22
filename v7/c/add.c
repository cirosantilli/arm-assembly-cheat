/* 1 + 2 == 3 */

#include <assert.h>
#include <inttypes.h>

int main(void) {
    uint32_t in0 = 1, in1 = 2, out;
    __asm__ (
        "add %0, %1, %2;"
        : "=r" (out)
        : "r"  (in0),
          "r"  (in1)
    );
    assert(in0 == 1);
    assert(in1 == 2);
    assert(out == 3);
}
