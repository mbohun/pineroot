LITERM_VERSION = 2812ebb42d51a054881bf793b753b3dc73dacd50
LITERM_SITE = https://github.com/rburchell/literm.git
LITERM_SITE_METHOD = git
LITERM_DEPENDENCIES = qt5base qt5xmlpatterns
LITERM_PREFIX = $(TARGET_DIR)/usr

define LITERM_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) PREFIX=/usr)
endef

define LITERM_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define LITERM_INSTALL_TARGET_CMDS
        (cd $(@D); cp literm $(LITERM_PREFIX)/bin)

endef

$(eval $(generic-package))

