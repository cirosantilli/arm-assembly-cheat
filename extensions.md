# Extensions

## NEON

SIMD extensions.

## Thumb

Introduced an alternative encoding to the previous ones, which has less functionality but greater density.

Bit 5 of the CPSR register determines if the processor expects thumb instructions or not.

Code density is super important in embedded, and this was a major source of ARM success.

TODO: how to set / reset that bit?

-   `BL, BLX (immediate)`: optionally at the same time as function calls! TODO is this the only way?

    Then on GAS we mark functions as being Thumb or not, and the compiler uses the right version of `BL`.

## Thumb-2

32-bit extensions to thumb.

TODO: how to enter that mode? Or is it a compatible extension to Thumb?
