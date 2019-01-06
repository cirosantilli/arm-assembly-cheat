/* https://github.com/cirosantilli/arm-assembly-cheat#ubfm */

#include "common.h"

ENTRY

    ldr x0, =0x1122334455667788

    ubfm x1, x0, 8, 16
    ASSERT_EQ(x1, 0x0000000000000077)

    ubfm x1, x0, 8, 32
    ASSERT_EQ(x1, 0x0000000000556677)

    ubfm x1, x0, 8, 48
    ASSERT_EQ(x1, 0x0000003344556677)

    ubfm x1, x0, 4, 16
    ASSERT_EQ(x1, 0x0000000000000778)

    ubfm x1, x0, 4, 32
    ASSERT_EQ(x1, 0x0000000005566778)

    ubfx x1, x0, 8, 16
    ASSERT_EQ(x1, 0x0000000000006677)

EXIT
