/* https://github.com/cirosantilli/arm-assembly-cheat#armv8-floaing-point */

#include "common.h"

.data;
big0:
    .double 1.5
big1:
    .double 2.5
big_sum:
    .double 4.0

ENTRY
    /* 1.5 + 2.5 == 4.0
     * using 64-bit double immediates.
     */
    fmov d0, #1.5
    fmov d1, #2.5
    fadd d2, d0, d1
    fmov d3, #4.0
    fcmp d2, d3
    beq 1f
    FAIL
1:

    /* Now with a memory stored value. */
    ldr d0, big0
    ldr d1, big1
    fadd d2, d0, d1
    ldr d3, big_sum
    fcmp d2, d3
    beq 1f
    FAIL
1:

    /* Now in 32-bit. */
    fmov s0, #1.5
    fmov s1, #2.5
    fadd s2, s0, s1
    fmov s3, #4.0
    fcmp s2, s3
    beq 1f
    FAIL
1:

    /* TODO why?
     * Error: operand mismatch -- `fmov q0,#1.5'
     */
#if 0
    fmov q0, #1.5
#endif

    /* Much like integers, immediates are constrained to
     * fit in 32-byte instructions. TODO exact rules.
     *
     * Assembly here would fail with:
     *
     * Error: invalid floating-point constant at operand 2
     */
#if 0
    fmov d0, #1.23456798
#endif

    # ASSERT_MEMCMP(sum, sum_expect, 0x20)
EXIT
