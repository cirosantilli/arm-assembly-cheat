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

/* Assert that a register equals another register. */
#define ASSERT_REG_EQ(reg1, reg2) \
	cmp reg1, reg2; \
	ASSERT(beq); \
;

#endif
