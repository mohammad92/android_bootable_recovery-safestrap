**Safestrap recovery based on (TWRP)**

Safestrap compiling guide:

- Sync this repo
- Sync to your build tree https://github.com/mohammad92/android_device_samsung
- In terminal run this
- source ./build/envsetup.sh
- lunch omni_$(TARGET_DEVICE)-eng
- make clean 
- make -j10 recoveryimage

After recovery compiled run this
- ~/$(ANDROID_TREE)/bootable/recovery/safestrap/devices/$(SS_PRODUCT_MANUFACTURER)/$(TARGET_DEVICE)/build-install.sh

You can find a compiling guide [here](http://forum.xda-developers.com/showthread.php?t=1943625 "Guide").
