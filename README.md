Device configuration for the Samsung Tab Pro 8.4

Copyright (C) 2019 The LineageOS Project
Copyright (C) 2019 Valera Chigir <valera1978@tut.by>

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

      http://www.apache.org/licenses/LICENSE-2.0

------------------------------------------------------------------

* Description

  This repository is for LineageOS on Samsung Tab Pro 8.4 (mondrianwifi)

* How To Build LineageOS for Samsung Tab Pro 8.4

  - Make a workspace

mkdir cm17
cd cm17

  - Do repo init & sync

repo init -u git://github.com/LineageOS/android.git -b lineage-17.1

  - Create .repo/local_manifests/roomservice.xml with the following content:

```
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
  <project name="Valera1978/android_device_samsung_mondrianwifi" path="device/samsung/mondrianwifi" remote="github" />
  <project name="Valera1978/android_kernel_samsung_msm8974" path="kernel/samsung/msm8974_tab" remote="github" revision="lineage-17.1_pro" />
  <project name="Valera1978/android_vendor_samsung_mondrianwifi" path="vendor/samsung/mondrianwifi" remote="github" />
  <project name="LineageOS/android_device_samsung_qcom-common" path="device/samsung/qcom-common" remote="github" />
  <project name="LineageOS/android_hardware_samsung" path="hardware/samsung" remote="github" />
</manifest>
```

repo sync

  - Copy proprietary vendor files

  There are two options to to that. Connect your device with adb enabled and run:

./extract-files.sh

  Or if you have the system image unpacked on your disk, then simply run:

    STOCK_ROM_DIR=/path/to/system ./extract-files.sh

  - Setup environment

. build/envsetup.sh

  - Build cm17

brunch mondrianwifi

or another way:

lunch lineage_mondrianwifi-userdebug
export USE_CCACHE=1
make -j16 bacon
