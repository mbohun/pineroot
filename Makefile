#
# Top level Makefile 
#
# Usage: 
#
# Start 'rsync --daemon' in your pinephone
#
# 'make update_rootfs' updates your rootfs with rsync
#
# Note: you need valid '/etc/rsyncd.conf' in your pinephone
#

COD_DIR=.
BUILDROOT_DIR = $(COD_DIR)/buildroot-2021.02.2
CONFIG_FILE ?= pinephone_defconfig
RSYNC_EXCLUDE =   --exclude="/etc/hostname" --exclude="/etc/passwd" --exclude='etc/dropbear' \
--exclude='/etc/shadow' --exclude='/tmp/*' --exclude='/dev/*' --exclude='*~' \
--exclude='/etc/hosts' 

# Change this to your pinephone ip
TARGET_IP ?= 192.168.5.194
SSHPORT = 22

all: pinephone

pinephone: 
	cd $(BUILDROOT_DIR) && make

pinephone_defconfig:
	cd $(BUILDROOT_DIR) && make $(CONFIG_FILE)

update_rootfs:
	$(info -------------------------------------------------------------------------------)
	$(info Updating current rootfs)
	$(info -------------------------------------------------------------------------------)
	rsync -e "ssh  -p $(SSHPORT) -l root" $(RSYNC_EXCLUDE) -rclvxW --ignore-times --super $(BUILDROOT_DIR)/output/target/ $(TARGET_IP)::root

update_kernel:
	$(info -------------------------------------------------------------------------------)
	$(info Updating kernel)
	$(info -------------------------------------------------------------------------------)
	ssh root@$(TARGET_IP) "mount /dev/mmcblk0p1 /mnt"
	scp $(BUILDROOT_DIR)/output/images/Image root@$(TARGET_IP):/mnt/Image
	ssh root@$(TARGET_IP) "umount /mnt"

clean:
	cd $(BUILDROOT_DIR) && make clean
