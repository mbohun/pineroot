PINEROUTER_VERSION = 8bcaf57c6f9b9632d5e227a0b409513cf352cc56
PINEROUTER_SITE = https://github.com/e59e4835/pinerouter.git
PINEROUTER_SITE_METHOD = git
PINEROUTER_DEPENDENCIES = qt5base qt5xmlpatterns
PINEROUTER_PREFIX = $(TARGET_DIR)/usr

MYQMAKE = $(TOPDIR)/output/host/usr/bin/qmake

define PINEROUTER_CONFIGURE_CMDS
	(cd $(@D) && $(MYQMAKE) -r PREFIX=$(PINEROUTER_PREFIX))
endef

define PINEROUTER_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define PINEROUTER_INSTALL_TARGET_CMDS
        (cd $(@D); cp pinerouter $(PINEROUTER_PREFIX)/bin)

endef

$(eval $(generic-package))

