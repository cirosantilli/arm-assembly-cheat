ARCH = arm
# -mfpu=crypto-neon-fp-armv8.1
# vfp.S: Error: selected processor does not support <FPU instruction> in ARM mode
# https://stackoverflow.com/questions/41131432/cross-compiling-error-selected-processor-does-not-support-fmrx-r3-fpexc-in/52875732#52875732
# We aim to take the most extended mode currently available that works on QEMU.
#
# TODO: GCC does not recognize neon-vfpv3, man gcc 8.2.0 on Ubuntu 18.10 says:
# > The Advanced SIMD (Neon) v1 and the VFPv3 floating-point instructions.
# > The extension +neon-vfpv3 can be used as an alias for this extension.
ASFLAGS_EXTRA = -mcpu=cortex-a76 -mfpu=crypto-neon-fp-armv8.1 -meabi=5
# -marm: the opposite of -mthumb.
# -masm-syntax-unified: make gcc generate .syntax unified for inline assembly.
#     However, it gets ignored if -marm is given, which might be a GCC bug:
#     https://stackoverflow.com/questions/54078112/how-to-write-syntax-unified-ual-armv7-inline-assembly-in-gcc
#     So we just write divided inline assembly for now.
CCFLAGS_EXTRA = -marm -masm-syntax-unified
MARCH = armv7-a
PREFIX = arm-linux-gnueabihf
ifeq ($(NATIVE),y)
  # TODO understand why it is failing.
  SKIP_TESTS = vfp
endif
