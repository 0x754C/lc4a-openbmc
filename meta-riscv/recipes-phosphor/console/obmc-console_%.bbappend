FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"
OBMC_CONSOLE_HOST_TTY = "ttyS0"
OBMC_CONSOLE_TTYS = "ttyS1 ttyS2 ttyS3 ttyS4 ttyS5 ttyACM0 ttyACM1"

SRC_URI:append = " file://server.ttyS1.conf \
		file://server.ttyS2.conf \
		file://server.ttyS3.conf \
		file://server.ttyS4.conf \
		file://server.ttyS5.conf \
		file://server.ttyACM0.conf \
		file://server.ttyACM1.conf \
		file://client.2201.conf \
		file://client.2202.conf \
		file://client.2203.conf \
		file://client.2204.conf \
		file://client.2205.conf \
		file://client.2206.conf \
		file://client.2207.conf \
"

CLIENT_SERVICE_FILES_FMT = "file://${BPN}-{0}@.service \
                            file://${BPN}-{0}.socket"

SRC_URI:append: = " ${@compose_list(d, 'CLIENT_SERVICE_FILES_FMT', 'OBMC_CONSOLE_TTYS')}"

CLIENT_SERVICE_FMT = " ${PN}-{0}@.service \
                       ${PN}-{0}.socket"

SYSTEMD_SERVICE:${PN}:append = " ${@compose_list(d, 'CLIENT_SERVICE_FMT', 'OBMC_CONSOLE_TTYS')} "

SRC_URI:remove = "file://${BPN}.conf"

SYSTEMD_SERVICE:${PN}:remove = "obmc-console-ssh.socket"
SYSTEMD_SERVICE:${PN}:remove = "obmc-console-ssh@.service"

PACKAGECONFIG:append = " concurrent-servers"

do_install:append() {
        # Install the server configuration
        install -m 0755 -d ${D}${sysconfdir}/${BPN}
        install -m 0644 ${WORKDIR}/*.conf ${D}${sysconfdir}/${BPN}/
}

do_install:append() {
        install -m 0644 ${WORKDIR}/${BPN}-*@.service ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/${BPN}-*.socket ${D}${systemd_system_unitdir}

        rm -rf ${D}${systemd_system_unitdir}/obmc-console-ssh@.service.d/
        rm -f ${D}${systemd_system_unitdir}/${BPN}-ssh@.service
        rm -f ${D}${systemd_system_unitdir}/${BPN}-ssh.socket
}

