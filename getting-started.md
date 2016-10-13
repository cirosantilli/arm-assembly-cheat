# Getting started

Ubuntu 16.04 amd64:

    sudo apt-get install gcc-arm-linux-gnueabihf gdb-multiarch qemu-user-static

TODO: Raspbian install.

Build all and examples:

    make

Run a single example on an emulator:

    make run-<basename-no-extension>

E.g.:

    make run-hello_driver

will run:

    hello_driver.S

Run all examples, exit status is non-zero if an example exits with non-zero:

    make test
