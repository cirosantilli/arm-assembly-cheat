# GAS

GNU assembler directives that are specific to ARM.

## .syntax unified

Just the more modern language notation version.

Architecture Reference Manual A4.2 Unified Assembler Language comments on it, and links to 

## .thumb_func

Marks a function as thumb.

This is per-function because ARM switches thumb mode on / off with the `BLx` instruction, which is also the call.
