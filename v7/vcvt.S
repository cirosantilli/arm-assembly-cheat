/* https://github.com/cirosantilli/arm-assembly-cheat#vcvt */

#include "common.h"

ENTRY
    /* SIMD positive. */
.data
    vcvt_positive_0:      .float 1.25, 2.5, 3.75, 4.0
    vcvt_positive_expect: .word  1,    2,   3,    4
.bss
    vcvt_positive_result: .skip 0x10
.text
    ldr r0, =vcvt_positive_0
    vld1.32 {q0}, [r0]
    vcvt.u32.f32 q1, q0
    ldr r0, =vcvt_positive_result
    vst1.32 {q1}, [r0]
    ASSERT_MEMCMP(vcvt_positive_result, vcvt_positive_expect, 0x10)

    /* SIMD negative. */
.data
    vcvt_negative_0:      .float -1.25, -2.5, -3.75, -4.0
    vcvt_negative_expect: .word  -1,    -2,   -3,    -4
.bss
    vcvt_negative_result: .skip 0x10
.text
    ldr r0, =vcvt_negative_0
    vld1.32 {q0}, [r0]
    vcvt.s32.f32 q1, q0
    ldr r0, =vcvt_negative_result
    vst1.32 {q1}, [r0]
    ASSERT_MEMCMP(vcvt_negative_result, vcvt_negative_expect, 0x10)

    /* Floating point. */
.data
    vcvt_positive_float_0:      .float 1.5, 2.5
    vcvt_positive_float_expect: .word  1
                                .float      2.5
.bss
    vcvt_positive_float_result: .skip 0x8
.text
    ldr r0, =vcvt_positive_float_0
    vld1.32 {d0}, [r0]
    vcvt.u32.f32 s0, s0
    ldr r0, =vcvt_positive_float_result
    vst1.32 {d0}, [r0]
    ASSERT_MEMCMP(vcvt_positive_float_result, vcvt_positive_float_expect, 0x8)

    /* Same but with immediates.
     *
     * Doing this mostly to illustrate the joys of vmov.i32.
     *
     * For some reason, there is no vmov.i32 sn, only dn.
     * If you try to use sn, it does the same as .f32 and
     * stores a float instead. Horrible!
     */
    vmov.f32 d0, 1.5
    vmov.i32 d1, 1
    vcvt.u32.f32 s0, s0
    vcmp.f32 s0, s2
    vmrs apsr_nzcv, fpscr
    ASSERT(beq)
    /* Check that s1 wasn't modified by vcvt. */
    vmov.f32 s2, 1.5
    vcmp.f32 s1, s2
    vmrs apsr_nzcv, fpscr
    ASSERT(beq)
EXIT
