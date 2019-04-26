## Safestrap recovery based on (TWRP) ##
------------------

To build:
```bash
cd <source-dir>
export ALLOW_MISSING_DEPENDENCIES=true
. build/envsetup.sh
lunch omni_<device>-eng
mka recoveryimage
mka safestrap_installer
```
You can find TWRP compiling guide [here](http://forum.xda-developers.com/showthread.php?t=1943625 "Guide").
