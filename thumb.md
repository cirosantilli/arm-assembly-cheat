# Thumb

Alternative encoding to the ARM mode. It has less functionality but greater code density:

- smaller instructions
- requires more instructions for the same job, but not as much as the size reduction

Speeds are similar.

Bit 5 of the CPSR register determines if the processor expects thumb instructions or not.

Code density is super important in embedded, and this was a major reason for the success of ARM.

Thumb ARM mode can be changed with:

-   `BLX`: optionally at the same time as function calls! TODO is this the only way?

    Then on GAS we mark functions as being Thumb or not, and the compiler uses the right version of `BL`.

*Interworking* means to use both thumb and ARM encoding on a single executable.

Android supports both Thumb and ARM: <http://stackoverflow.com/questions/2380152/android-ndk-does-it-support-straight-arm-code-or-just-thumb>

## Vs ARM

TODO: do it all in a runnable test.

-   Instructions can have only 2 operands as in:

        add r0, #1

    not three as in;

        add r0, r1, #1

    which you would have to re-write as:

        add r0, r1
        add r0, #1

## Thumb-2

32-bit extensions to thumb.

TODO: how to enter that mode? Or is it a compatible extension to Thumb?
