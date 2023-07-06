SUMMARY = "bl702-firmware-dualuart"
DESCRIPTION = "uart firmware for bl702/bl706 mcu"
SECTION = "devtools"
SRC_URI = " file://bl702_dualuart_whole_img.bin \
	file://bl706_flash.sh"
LICENSE = "CLOSED"

inherit allarch

FILES:${PN} += "/usr/lib/firmware/bl702_dualuart_whole_img.bin"
FILES:${PN} += "/usr/lib/firmware/bl706_flash.sh"

do_compile() {
	:
}

do_install() {
        install -d ${D}/${nonarch_base_libdir}/firmware/
        install -m 0755 ${B}/../bl702_dualuart_whole_img.bin ${D}/${nonarch_base_libdir}/firmware/
        install -m 0755 ${B}/../bl706_flash.sh ${D}/${nonarch_base_libdir}/firmware/
}
