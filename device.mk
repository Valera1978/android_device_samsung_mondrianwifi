#
# Copyright (C) 2011 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Get non-open-source specific aspects
$(call inherit-product-if-exists, vendor/samsung/viennalte/viennalte-vendor.mk)

# We are a tablet, not a phone
PRODUCT_CHARACTERISTICS := tablet

# overlays
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi

$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)

$(call inherit-product-if-exists, frameworks/native/build/phone-xxxhdpi-3072-hwui-memory.mk)

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.consumerir.xml:system/etc/permissions/android.hardware.consumerir.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/tablet_core_hardware.xml:system/etc/permissions/tablet_core_hardware.xml \
    frameworks/native/data/etc/android.software.freeform_window_management.xml:system/etc/permissions/android.software.freeform_window_management.xml

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/mixer_paths.xml:system/etc/mixer_paths.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf

# Camera
PRODUCT_PACKAGES += \
    camera.msm8974 \
    libxml2

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/flp.conf:system/etc/flp.conf

# Input device
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/idc/sec_e-pen.idc:system/usr/idc/sec_e-pen.idc

# IR
PRODUCT_PACKAGES += \
    consumerir.msm8974

# Keylayouts
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl \
    $(LOCAL_PATH)/keylayout/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    $(LOCAL_PATH)/keylayout/sec_touchscreen.kl:system/usr/keylayout/sec_touchscreen.kl

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8974

# Lights
PRODUCT_PACKAGES += \
    lights.msm8974

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

# Radio
PRODUCT_PACKAGES += \
    libril_shim

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.carrier.rc \
    init.crda.sh \
    init.input.sh \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.target.rc \
    ueventd.qcom.rc

# Ssl
PRODUCT_PACKAGES += \
    libboringssl-compat

# Stlport
PRODUCT_PACKAGES += \
    libstlport

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf \
    $(LOCAL_PATH)/configs/thermald-8974.conf:system/etc/thermald-8974.conf

# Wifi
PRODUCT_PACKAGES += \
    dhcpcd.conf \
    hostapd \
    hostapd_default.conf \
    libwcnss_qmi \
    libwpa_client \
    macloader \
    wcnss_service \
    wpa_supplicant

# IPv6 tethering
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_SCREEN_WIDTH := 2560
TARGET_SCREEN_HEIGHT := 1600

# Default Properties
#ADDITIONAL_DEFAULT_PROPERTIES += \
#    persist.service.adb.enable=1 \
#    persist.service.debuggable=1 \
#    ro.adb.secure=0

# Wifi
PRODUCT_PACKAGES += \
   libnetcmdiface

# Common msm8974
$(call inherit-product, device/samsung/msm8974-common/msm8974.mk)
