#!/bin/bash

if [ ! -d .repo ]; then

# initialize repository
repo init --depth=1 -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-7.1

mkdir .repo/local_manifests
# create local manifest for Suzuran
cat >.repo/local_manifests/sony-suzuran.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote  name="greyleshy"
           fetch="https://github.com/GreyLeshy" />
  <project path="device/sony/suzuran" name="android_sony_kitakami_twrp" remote="greyleshy" revision="suzuran" />
</manifest>
EOF
# create local manifest with password protected TWRP
cat >.repo/local_manifests/ant9000-twrp.xml <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <remote  name="ant9000"
           fetch="https://github.com/ant9000" />
  <remove-project name="android_bootable_recovery" />
  <project path="bootable/recovery" name="android_bootable_recovery" remote="ant9000" revision="android-9.0" groups="pdk-cw-fs"/>
</manifest>
EOF
fi

# update repository
repo sync

# ask for password protection (unless already in place)
grep "tw_unlock_pass=0" bootable/recovery/gui/theme/common/portrait.xml >/dev/null
status=$?
if [ $status -eq 0 ]; then
cat <<EOF

If you would like to set a password to protect your TWRP image, exit now and edit the file

    bootable/recovery/gui/theme/common/portrait.xml

Simply change line 769 from

    <action function="set">tw_unlock_pass=0</action>

to

    <action function="set">tw_unlock_pass=YOURUNFORGETTABLEPASSWORD</action>

After saving, relaunch this script.

Press Ctrl-C to exit, any key to proceed.
EOF
read
fi

# build it
. build/envsetup.sh
lunch omni_suzuran-userdebug
make -j$(nproc) recoveryimage

cat <<EOF

You can now flash your new recovery image with:

   sudo fastboot flash recovery $OUT/recovery.img

EOF