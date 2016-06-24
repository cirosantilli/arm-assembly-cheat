# GAS

GNU assembler syntax and directives that are specific to ARM.

Also discusses

## .syntax unified

Just the more modern language notation version.

Architecture Reference Manual A4.2 Unified Assembler Language comments on it, and links to 

Documented at: <https://sourceware.org/binutils/docs/as/ARM_002dInstruction_002dSet.html#ARM_002dInstruction_002dSet>

## .thumb_func

Marks a function as thumb.

This is per-function because ARM switches thumb mode on / off with the `BLx` instruction, which is also the call.

See: <https://sourceware.org/binutils/docs/as/ARM-Directives.html>

## Registers

ARM manual does not use percent `%`, GNU GAS accepts both with or without. So we just do without.

TODO Ambiguity with memory labels is avoided through the equals sign `=` for memory?

## Integer constants

## Immediates

Both hash sign `#` or dollar sign work `$`:

    mov 0, #3
    mov 0, $3

<https://sourceware.org/binutils/docs/as/ARM_002dChars.html#ARM_002dChars>

TODO: is dollar specified by ARM? Prefer hash because the ARM manual uses it.

## Condition codes

<http://www.davespace.co.uk/arm/introduction-to-arm/conditional.html>
