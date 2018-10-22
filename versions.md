# Versions

## ISA

The hardware APIs.

Name of type:

    ARMv<N>[<EXTRA>]

E.g.:

- ARMv7-A (e.g. Cortex A7, Raspberry Pi 2)

TODO backwards compatible?

- <https://community.arm.com/thread/7510>
- <http://stackoverflow.com/questions/25003133/backwards-compatibility-of-arm-v7-isa-to-arm-v2-isa>
- <http://stackoverflow.com/questions/19608570/what-parts-of-armv4-5-6-code-will-not-work-on-armv7>
- <http://stackoverflow.com/questions/6771941/how-to-find-out-if-cpu-is-arm-v5-cpu-instructions-compatible>

## Implementations

The ARM ISA is much more fragmented / less backwards compatible than X86.

<https://en.wikipedia.org/wiki/List_of_ARM_microarchitectures> has an awesome breakdown, and shows the hierarchy:

- family
- architecture: the ISA, API exposed to software programmers
- core: an specific core name. Licensees can then combine multiple cores into a single SoC.

<http://www.davespace.co.uk/arm/introduction-to-arm/arm-arch123.html> and following chapters have a good summary of the evolution of the architecture.

### Cortex

Family name of the most recent CPUs.

There are three subdivisions for different markets: A, R and M.

Great move by ARM, which greatly clarified branding.

First `ARMX` family branding, which looks too similar to the `ARMvX` architecture names.

Next, specific cores are named just as:

- A7
- A32
- A53

A35 and up are 64 bit.

Compare that to the insanely long names of older families, e.g. `ARM1176JZF-S`.

#### Cortex A

https://en.wikipedia.org/wiki/ARM_Cortex-A

Has MMU.

#### Cortex R

https://en.wikipedia.org/wiki/ARM_Cortex-R

Real time use.

#### Cortex M

Low power.

The least powerful line: <http://www.design-reuse.com/articles/26106/cortex-r-versus-cortex-m.html>

### ARMv7

Added floating point operations.

### ARM11

<https://en.wikipedia.org/wiki/ARM11>

First release: 2002.
