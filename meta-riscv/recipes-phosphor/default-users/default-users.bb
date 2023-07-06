SUMMARY = "Add default Users"
DESCRIPTION = "Add Users"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

EXCLUDE_FROM_WORLD = "1"

DEPENDS += "phosphor-user-manager"
RDEPENDS:${PN} += "phosphor-user-manager"

inherit useradd
USERADD_PACKAGES = "${PN}"

GROUPMEMS_PARAM:${PN} = "-g priv-admin -a root; "
