/* C hello world compiled to ARM with libc access. */

#include <stdio.h>

int main(void) {
#ifdef __arm__
    puts("hello world");
#endif
    return 0;
}
