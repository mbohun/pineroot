VIDEOENGINE_VERSION = 6d4301fa1cecdfc33775184feec863b2c9a195c0
VIDEOENGINE_SITE = https://github.com/pfect/videoengine.git
VIDEOENGINE_SITE_METHOD = git
VIDEOENGINE_DEPENDENCIES = libglib2 host-pkgconf gstreamer1
VIDEOENGINE_PREFIX = $(TARGET_DIR)/usr

$(eval $(autotools-package))

define VIDEOENGINE_INSTALL_TARGET_CMDS
        (cd $(@D); cp src/videosend $(VIDEOENGINE_PREFIX)/bin)

endef


