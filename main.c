#include "stdio.h"

int asm_main(void) __attribute__((target("arm")));

int main(void) {
	int ret;
	ret = asm_main();
    return ret;
}

#if 0

#include "stdio.h"

int asm_main(int *line) __attribute__((target("arm")));

int main(void) {
	int ret, line;
	ret = asm_main(&line);
	if (ret) {
		printf("error %d at line %d\n", ret, line);
	}
    return ret;
}

#endif
