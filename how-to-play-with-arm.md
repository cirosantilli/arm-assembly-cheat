# How to play with ARM

You are on an x86 machine.

To compile arm binaries, we need a cross compiler. Options:

-   reuse the cross compiler of your distro. Super easy. Best way.

-   compile GCC for it. Annoying setup and takes 2 hours.

-   use the pre-compiled cross-compilers of `android-ndk`.

    This functionality is explicitly documented at: <https://developer.android.com/ndk/guides/standalone_toolchain.html>

    But I run into some trouble: <http://android.stackexchange.com/questions/149074/how-to-compile-a-dynamically-linked-c-program-with-the-standalone-toolchain-and>

How to run the compiled binaries? Options:

-   Android:
    - `adb push` executable, and then `adb shell`. But I can't get it working no matter what: <http://stackoverflow.com/questions/9868309/how-can-i-run-c-binary-executable-file-in-android-from-android-shell>
    - NDK. Yup, that works.
-   Raspberry PI:
    - real device: should be easy?
    - emulation: not simple: <http://raspberrypi.stackexchange.com/questions/165/emulation-on-a-linux-pc>
-   QEMU
    - user mode emulation: very simple and magic
    - system mode: if you get your hands on pre-compiled ARM image with Linux, glibc, maybe GCC, should be simple
