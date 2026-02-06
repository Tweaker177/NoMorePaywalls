export THEOS_PACKAGE_SCHEME=rootful
export TARGET = iphone:clang:latest:14.0
export ARCHS = arm64 arm64e
export INSTALL_TARGET_PROCESSES += News NewsSubscription
export FINALPACKAGE = 1
export PACKAGE_VERSION = 0.0.6
GO_EASY_ON_ME = 1

export SYSROOT = $(THEOS)/sdks/iPhoneOS11.2.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NoMorePaywalls
NoMorePaywalls_FILES = Tweak.xm
NoMorePaywalls_CGFLAGS += -f-objc-arc -Wno-error -Wno-deprecated-declarations
NoMorePaywalls_FRAMEWORKS = UIKit Foundation
NoMorePaywalls_PRIVATE_FARAMEWORKS= NewsSubscription

include $(THEOS_MAKE_PATH)/tweak.mk