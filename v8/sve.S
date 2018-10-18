/* Example from: https://developer.arm.com/docs/dui0965/latest/getting-started-with-the-sve-compiler/assembling-sve-code */

#include "common.h"

ENTRY
    mov x0, 0x90000000
    mov x8, xzr
    ptrue p0.s
    fcpy z1.s, p0/m, #5.00000000
    orr w10, wzr, #0x400
loop:
    st1w z0.s, p0, [x0, x8, lsl #2]
    incw x8
    whilelt p0.s, x8, x10
    b loop
    mov w0, wzr
    // ASSERT_EQ(x0, 0x1111222233334444)
EXIT
