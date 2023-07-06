FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://muxctl.sh \
    "

RDEPENDS:${PN}:append = " bash"

do_install:append() {
    install -d ${D}${libexecdir}/${PN}
    install -m 0755 ${WORKDIR}/muxctl.sh ${D}${libexecdir}/${PN}/
}
