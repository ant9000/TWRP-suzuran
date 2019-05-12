# TWRP-suzuran
This repository consists of a single TWRP build script, that will create a recovery image for Sony Z5 Compact "suzuran".

For building, I use my own [android_bootable_recovery](https://github.com/ant9000/android_bootable_recovery), which tweaks the TWRP theme in order to protect recovery with a password. The script will guide you on how to add a password during image creation.

You will need repo and Android build tools to correctly build TWRP on your machine.

Have a look at LineageOS wiki for the prerequisites:

   https://wiki.lineageos.org/devices/suzuran/build

If you are just looking for a prebuilt image (with no password set), simply download the latest [release](https://github.com/ant9000/TWRP-suzuran/releases). You could still password-protect it, using my other project [TWRP-protect](https://github.com/ant9000/TWRP-protect).
