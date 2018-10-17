/* https://github.com/cirosantilli/arm-assembly-cheat#x31 */

#include "common.h"

ENTRY
    /* ERROR, cannot use this name. */
    /* mov x31, #31 */

    /* For mov, it is xzr. */
    mov x0, 1
    mov x0, xzr
    ASSERT_EQ(x0, 0)

    /* Discards result if written. */
    mov xzr, 1
    ASSERT_EQ(xzr, 0)
EXIT
