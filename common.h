#ifndef COMMON_H
#define COMMON_H

#include "common_arch.h"

.extern \
    exit, \
    printf, \
    puts \
;

/* Assert that the given branch instruction is taken. */
#define ASSERT(branch_if_pass) \
    branch_if_pass 1f; \
    FAIL; \
1: \
;

#endif
