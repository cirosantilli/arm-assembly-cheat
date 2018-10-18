ARCH = arm
# The opposite of -mthumb.
ASFLAGS_EXTRA =-mfpu=vfpv3-d16
CFLAGS_EXTRA = -marm
MARCH = armv7-a
PHONY_MAKES = linux
PREFIX = arm-linux-gnueabihf
