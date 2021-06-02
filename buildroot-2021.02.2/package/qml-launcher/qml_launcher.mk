QML_LAUNCHER_VERSION = 7e008ffaf24c99beeda89c331f3f2211f89c4537
QML_LAUNCHER_SITE = https://github.com/alamminsalo/qml-launcher.git
QML_LAUNCHER_SITE_METHOD = git
QML_LAUNCHER_DEPENDENCIES = qt5base
QML_LAUNCHER_PREFIX = $(TARGET_DIR)/usr

define QML_LAUNCHER_CONFIGURE_CMDS
	(cd $(@D); $(TARGET_MAKE_ENV) $(QT5_QMAKE) PREFIX=/usr)
endef

define QML_LAUNCHER_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define QML_LAUNCHER_INSTALL_TARGET_CMDS
        (cd $(@D); cp qml-launcher $(QML_LAUNCHER_PREFIX)/bin)

endef

$(eval $(generic-package))
