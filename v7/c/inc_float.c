/* TODO get working. */

#include <assert.h>

int main(void) {
#if 0
    float io = 1.5;
    __asm__ (
        "vmov s1, 1.0;"
        "vadd.f32 s2, s0, s1;"
        "vmov s3, 4.0;"
        : "+r" (io)
        :
        : "s1"
    );
    assert(io == 2.5);
#endif
}
