ARCH = arm
# -mfpu:
# vfp.S: Error: selected processor does not support <FPU instruction> in ARM mode
# https://stackoverflow.com/questions/41131432/cross-compiling-error-selected-processor-does-not-support-fmrx-r3-fpexc-in/52875732#52875732
ASFLAGS_EXTRA = -mfpu=neon-vfpv3 -meabi=5
# -marm: the opposite of -mthumb.
CFLAGS_EXTRA = -marm
MARCH = armv7-a
PREFIX = arm-linux-gnueabihf
