/*
This C driver is used to make it easier to use the C standard library,
to allow for OS portable portable IO.

https://gcc.gnu.org/onlinedocs/gcc-6.1.0/gcc/ARM-Function-Attributes.html
thumb seems to be the default.

The initial state of `main` can be passed to gcc with:

    -mthumb
    -marm

https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html

TODO this was making no difference under -mthumb and things still failed
if the .S did not specify .thumb-function. Why?
*/

int asm_main(void) __attribute__((target("arm")));

int main(void) {
    return asm_main();
}
