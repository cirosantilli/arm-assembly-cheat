# Vs x86

Things that feel weird / new:

- <https://en.wikipedia.org/wiki/Link_register>
- IT register <http://stackoverflow.com/questions/20886563/point-of-it-instruction-arm-assembly>
- Thumb: ARM has two encodings and can switch between them at runtime
- bi-directional endianess controlled by a control bit
- instructions for <https://en.wikipedia.org/wiki/Saturation_arithmetic> TODO applications?
- <https://en.wikipedia.org/wiki/Jazelle>
- many instruction can be executed conditionally, e.g. `moveq`, not just branching like most of x86. TODO: does it have encoding support, or just sugar?
- `STM` and `LDM` stack operations both increment and decrement the stack pointer, both before and after writing data
- ARM has <https://en.wikipedia.org/wiki/Load/store_architecture>, x86 not. Elegant design choice.
