FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

DEPENDS:append = " u-boot-tools-native"

# Overwrite this for your server
TFTP_SERVER_IP ?= "127.0.0.1"

# Only add opensbi dependency if opensbi is in image deps
do_compile[depends] += "opensbi:do_deploy"
