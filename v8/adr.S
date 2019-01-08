/* https://github.com/cirosantilli/arm-assembly-cheat#adr */

#include "common.h"

.data
data_label:
    .word 0x1234678
ENTRY
    /* This is not possible in v7 because the label is in another section.
     * objdump says that this generates a R_AARCH64_ADR_PRE relocation.
     * which looks specific to ADR, and therefore makes it more likely
     * that there was no such relocation in v7.
     */
    adr x0, data_label
    ldr x1, =data_label
label:
    ASSERT_EQ_REG(x0, x1)
EXIT
