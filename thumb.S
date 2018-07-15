/* Illustrates Thumb things that are different from ARM. */
.text
.thumb_func
.global asm_main
asm_main:
    /* Only available in Thumb. */

        /* CBZ: cmp and branch if zero instruction. Equivalent to CMP + BEQ. */
        cbz r1, 1f
        1:

        /* TODO check if only available in Thumb.
         * Related: http://stackoverflow.com/questions/15587060/return-from-a-procedure-in-arm-assembly
         */
        /*
        PUSH {...} is the Thumb equivalent of the ARM instruction STMDB SP!,{...}
        POP {...} is the Thumb equivalent of the ARM instruction LDMIA SP!,{...}
        */

    mov r0, #0
    bx lr
