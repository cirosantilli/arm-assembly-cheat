/*
C hello world compiled to ARM with libc access.

A sanity check that our cross-compilation is working fine.
*/

#include <stdio.h>

int main(void) {
#ifdef __arm__
    puts("hello world");
#endif
    return 0;
}
