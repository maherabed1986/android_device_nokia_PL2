#
# Copyright 2018 The Android Open Source Project
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

# Release name
PRODUCT_RELEASE_NAME := PL2

$(call inherit-product, build/target/product/embedded.mk)

# Inherit language packages
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# A/B updater
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    system \
    vendor \
    keymaster \
    splash

# A/B OTA dexopt package
PRODUCT_PACKAGES += otapreopt_script

# Crypto
#PRODUCT_PACKAGES += \
#   libcryptfs_hw

PRODUCT_PACKAGES += \
    charger_res_images \
    charger

# Setup dm-verity configs
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/platform/soc/c0c4000.sdhci/by-name/system
PRODUCT_VENDOR_VERITY_PARTITION := /dev/block/platform/soc/c0c4000.sdhci/by-name/vendor
$(call inherit-product, build/target/product/verity.mk)

# Treble Enabled
PRODUCT_PROPERTY_OVERRIDES += \
    ro.treble.enabled=true

	# Partitions (listed in the file) to be wiped under recovery.
TARGET_RECOVERY_WIPE := \
    device/nokia/PL2/recovery/root/etc/recovery.wipe

# ROM fstab
PRODUCT_COPY_FILES += \
  device/nokia/PL2/rootdir/root/fstab.qcom:root/fstab.qcom

# OEM Unlock reporting
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    ro.oem_unlock_supported=1

# Define time zone data path
ifneq ($(wildcard bionic/libc/zoneinfo),)
    TZDATAPATH := bionic/libc/zoneinfo
else ifneq ($(wildcard system/timezone),)
    TZDATAPATH := system/timezone/output_data/iana
endif

# Time Zone data for Recovery
ifdef TZDATAPATH
PRODUCT_COPY_FILES += \
    $(TZDATAPATH)/tzdata:recovery/root/system/usr/share/zoneinfo/tzdata
endif
	
## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := PL2
PRODUCT_NAME := omni_PL2
PRODUCT_BRAND := Nokia
PRODUCT_MODEL := 6.1
PRODUCT_MANUFACTURER := Nokia
