AUDIOSTREAMER_VERSION = 4551a188c9f1480f0f31ad2a63dda10e302934b8
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
