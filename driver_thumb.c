int asm_main(void) __attribute__((target("thumb")));

int main(void) {
    return asm_main();
}
