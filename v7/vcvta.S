/* https://github.com/cirosantilli/arm-assembly-cheat#vcvta */

#include "common.h"

ENTRY
    /* Positive. */
.data
    vcvt_positive_0:      .float 1.25, 2.5, 3.75, 4.0
    vcvt_positive_expect: .word  1,    3,   4,    4
.bss
    vcvt_positive_result: .skip 16
.text
    ldr r0, =vcvt_positive_0
    vld1.f32 {q0}, [r0]
    vcvta.u32.f32 q1, q0
    ldr r0, =vcvt_positive_result
    vst1.f32 {q1}, [r0]
    ASSERT_MEMCMP(vcvt_positive_result, vcvt_positive_expect, 0x10)

    /* Negative. */
.data
    vcvt_negative_0:      .float -1.25, -2.5, -3.75, -4.0
    vcvt_negative_expect: .word  -1,    -3,   -4,    -4
.bss
    vcvt_negative_result: .skip 16
.text
    ldr r0, =vcvt_negative_0
    vld1.f32 {q0}, [r0]
    vcvta.s32.f32 q1, q0
    ldr r0, =vcvt_negative_result
    vst1.f32 {q1}, [r0]
    ASSERT_MEMCMP(vcvt_negative_result, vcvt_negative_expect, 0x10)
EXIT
