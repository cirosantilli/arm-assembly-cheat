# Getting started

Ubuntu 16.04 amd64:

    sudo apt-get install gcc-arm-linux-gnueabihf gdb-multiarch qemu-user-static

Build all examples:

    make

Run a single example on an emulator:

    make run-<basename-no-extension>

E.g.:

    make run-hello_driver

will run:

    hello_driver.S

Test that all examples exit with status 0:

    make test

Debug one example with GDB:

    make debug-hello_driver
