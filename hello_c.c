/* C hello world compiled to ARM with libc access.
 *
 * Sanity check that our cross-compilation + emulator is working fine.
 *
 * Does not use any ARM assembly directly.
 */

#include <stdio.h>

int main(void) {
    puts("hello world");
    return 0;
}
