PINEUI_VERSION = d98de432f1d8336141cbd561d321584d18138186
PINEUI_SITE = https://github.com/e59e4835/pine-ui.git
PINEUI_SITE_METHOD = git
PINEUI_DEPENDENCIES = qt5base qt5xmlpatterns
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

