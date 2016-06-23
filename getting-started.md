# Getting started

## Ubuntu 16.04

### Ubuntu 16.04 emulation

Run:

    sudo apt-get install gcc-arm-linux-gnueabihf qemu-user-static

qemu-arm-static -L /usr/arm-linux-gnueabihf ./a.out

Build all and run all tests:

    make
