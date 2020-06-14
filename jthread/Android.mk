LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)
LOCAL_MODULE    := libjthread
LOCAL_CFLAGS =  -DJTHREAD_SKIP_PTHREAD_CANCEL
LOCAL_C_INCLUDES := $(LOCAL_PATH)/src
LOCAL_LDLIBS := 
LOCAL_SRC_FILES :=  \
src/pthread/jmutex.cpp \
src/pthread/jthread.cpp \

include $(BUILD_SHARED_LIBRARY)
#include $(BUILD_STATIC_LIBRARY)
