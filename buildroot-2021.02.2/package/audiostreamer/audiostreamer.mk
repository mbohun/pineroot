AUDIOSTREAMER_VERSION = 9c941185b573b17e6eb65f58089d379503f34826
AUDIOSTREAMER_SITE = https://github.com/pfect/audiostreamer.git
AUDIOSTREAMER_SITE_METHOD = git
AUDIOSTREAMER_DEPENDENCIES = gstreamer1 gst1-plugins-base
AUDIOSTREAMER_PREFIX = $(TARGET_DIR)/usr
AUDIOSTREAMER_LICENSE = gplv2

define AUDIOSTREAMER_INSTALL_TARGET_CMDS
        (cd $(@D); cp src/audiostreamer $(AUDIOSTREAMER_PREFIX)/bin)
endef

define AUDIOSTREAMER_CLEAN_CMDS
        $(MAKE) $(AUDIOSTREAMER_MAKE_OPTS) -C $(@D) clean
endef

$(eval $(autotools-package))
