#include "stdio.h"
#include "stdint.h"

int asm_main(uint32_t *line) __attribute__((target("arm")));

int main(void) {
    uint32_t ret, line;
    ret = asm_main(&line);
    if (ret) {
        printf("error %d at line %d\n", ret, line);
    }
    return ret;
}
