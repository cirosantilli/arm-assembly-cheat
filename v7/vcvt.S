/* https://github.com/cirosantilli/arm-assembly-cheat#vcvt */

#include "common.h"

ENTRY
.data
    vcvt_0:      .float 1.5, 2.5, 3.5, 4.5
    vcvt_expect: .word  1,   2,   3,   4
.bss
    vcvt_result: .skip 16
.text
    ldr r0, =vcvt_0
    vld1.f32 {q0}, [r0]
    vcvt.u32.f32 q1, q0
    ldr r0, =vcvt_result
    vst1.f32 {q1}, [r0]
    ASSERT_MEMCMP(vcvt_result, vcvt_expect, 0x10)
EXIT
