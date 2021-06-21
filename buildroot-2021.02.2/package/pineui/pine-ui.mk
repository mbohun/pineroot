PINEUI_VERSION = 8bcaf57c6f9b9632d5e227a0b409513cf352cc56
PINEUI_SITE = https://github.com/e59e4835/pine-ui.git
PINEUI_SITE_METHOD = git
PINEUI_DEPENDENCIES = qt5base qt5quickcontrols2
PINEUI_PREFIX = $(TARGET_DIR)/usr

MYQMAKE = $(TOPDIR)/output/host/usr/bin/qmake

define PINEUI_CONFIGURE_CMDS
	(cd $(@D) && $(MYQMAKE) -r PREFIX=$(PINEUI_PREFIX))
endef

define PINEUI_BUILD_CMDS
	$(MAKE) -C $(@D)
endef

define PINEUI_INSTALL_TARGET_CMDS
        (cd $(@D); cp pine-ui $(PINEUI_PREFIX)/bin)

endef

$(eval $(generic-package))

