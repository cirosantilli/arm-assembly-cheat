# Registers

## LR

## Link register

Same as R14.

Automatically set as the return value after a function call. Neat.

For non-leaf function calls, you must save it to memory, often with: TODO check:

    PUSH {,LR}
    POP {,PC}

## PC

Points to the instruction after the next: <http://stackoverflow.com/questions/24091566/understanding-the-nature-of-arm-pc-register>

Linked to old 3-stage pipeline, which beyond their expectations became 15 :-)
