PINEROUTER_VERSION = 8b339eecc4f5dc31fd8ff9424c34fd9d4a5b4c02
PINEROUTER_SITE = https://github.com/e59e4835/pinerouter-ui.git
PINEROUTER_SITE_METHOD = git
PINEROUTER_DEPENDENCIES = qt5base qt5quickcontrols2
PINEROUTER_PREFIX = $(TARGET_DIR)/usr

MYQMAKE = $(TOPDIR)/output/host/usr/bin/qmake

define PINEROUTER_CONFIGURE_CMDS
	(cd $(@D) && $(MYQMAKE) -r PREFIX=$(PINEROUTER_PREFIX))
endef

define PINEROUTER_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define PINEROUTER_INSTALL_TARGET_CMDS
        (cd $(@D); cp pinerouter-ui $(PINEROUTER_PREFIX)/bin)

endef

$(eval $(generic-package))

