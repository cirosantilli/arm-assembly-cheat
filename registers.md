# Registers

<https://en.wikipedia.org/wiki/ARM_architecture#Registers>

## Registers with special names

<http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0473e/CJAJBFHC.html>

### SB

### R9

Static base register.

TODO.

### FP

### Frame pointer

### R11

<https://community.arm.com/thread/7092>

### IP

### R12

Intra procedure call scratch register

TODO

### SP

### Stack pointer

### R13

Stack pointer, much like Intel's.

### LR

### Link register

### R14

LR is an alias for `R14`.

Automatically set as the return value after a function call. Neat.

For non-leaf function calls, you must save it to memory, often with: TODO check:

    PUSH {,LR}
    POP {,PC}

### PC

### Program counter

### R15

PC is an alias for `R15`, which is the program counter.

Points to the instruction *after* the next: <http://stackoverflow.com/questions/24091566/understanding-the-nature-of-arm-pc-register>

Linked to old 3-stage pipeline, which beyond their expectations became 15 :-)

## CPSR

## Current Program Status Register

Holds flags, some influence operations, other are outputs of operations like equality / greater than.
