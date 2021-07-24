VIDEOBRIDGE_VERSION = 07b879b1b7d45e22635ea597bbde824bd2c80753
VIDEOBRIDGE_SITE = https://github.com/pfect/videobridge.git
VIDEOBRIDGE_SITE_METHOD = git
VIDEOBRIDGE_DEPENDENCIES = qt5base qt5quickcontrols2 qt5multimedia gst1-libav
VIDEOBRIDGE_PREFIX = $(TARGET_DIR)/usr

MYQMAKE = $(TOPDIR)/output/host/usr/bin/qmake

define VIDEOBRIDGE_CONFIGURE_CMDS
	(cd $(@D) && $(MYQMAKE) -r PREFIX=$(VIDEOBRIDGE_PREFIX))
endef

define VIDEOBRIDGE_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define VIDEOBRIDGE_INSTALL_TARGET_CMDS
        (cd $(@D); cp videobridge $(VIDEOBRIDGE_PREFIX)/bin)

endef

$(eval $(generic-package))

