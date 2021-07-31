AUDIORECEIVER_VERSION = d9e1804766076406e9fe308d5ad761fab799aa30
AUDIORECEIVER_SITE = https://github.com/pfect/audioreceiver.git
AUDIORECEIVER_SITE_METHOD = git
AUDIORECEIVER_DEPENDENCIES = gstreamer1 gst1-plugins-base
AUDIORECEIVER_PREFIX = $(TARGET_DIR)/usr
AUDIORECEIVER_LICENSE = gplv2

define AUDIORECEIVER_INSTALL_TARGET_CMDS
        (cd $(@D); cp src/audioreceiver $(AUDIORECEIVER_PREFIX)/bin)
endef

define AUDIORECEIVER_CLEAN_CMDS
        $(MAKE) $(AUDIORECEIVER_MAKE_OPTS) -C $(@D) clean
endef

$(eval $(autotools-package))
