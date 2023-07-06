SUMMARY = "blisp"
DESCRIPTION = "blisp"
LICENSE = "MIT"
SECTION = "devtools"
LIC_FILES_CHKSUM = "file://LICENSE;md5=d50341c7b61d5dc41af96a2d4bc86c38"
SRC_URI = "git://github.com/pine64/blisp;branch=master;tag=5e09eca00d6fff8231441573b6a0ad129c6dcebe;protocol=https \
        gitsm://github.com/argtable/argtable3;btranch=master;tag=6f0e40bc44c99af353ced367c6fafca8705f5fca;protocol=https;destsuffix=git/vendor/argtable3 \
        gitsm://github.com/sigrokproject/libserialport;btranch=master;tag=6f9b03e597ea7200eb616a4e410add3dd1690cb1;protocol=https;destsuffix=git/vendor/libserialport \
        file://0001-tools-blisp-CMakeLists.txt-need-libm.patch \
        "
PR = "r0"
S = "${WORKDIR}/git"

inherit cmake pkgconfig

EXTRA_OECMAKE = "-DBLISP_BUILD_CLI=ON"

do_install:append() {
        install -d ${D}${base_bindir}
        install -m 0755 ${B}/tools/blisp/blisp ${D}${base_bindir}/
}
