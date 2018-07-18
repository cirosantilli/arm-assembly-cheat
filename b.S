/* https://github.com/cirosantilli/arm-assembly-cheat#b */

#include "common.h"
ENTRY
    /* Jump over the fail. */
    b ok
    FAIL
ok:
EXIT
