LOCAL_PATH := $(call my-dir)

# libqc-opt

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
     icu53.c

LOCAL_SHARED_LIBRARIES := libicuuc libicui18n
LOCAL_MODULE := libshim_qcopt
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)

# libshim_rmt_storage

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
     ioprio.c

LOCAL_MODULE := libshim_rmt_storage
LOCAL_MODULE_TAGS := optional

include $(BUILD_SHARED_LIBRARY)
