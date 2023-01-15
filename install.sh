#!/bin/bash -e

BASEPATH=$(dirname $0)

source ${BASEPATH}/common-setup.sh

checkOS
setup_script="${BASEPATH}/setup.${PLATFORM_DISTRO}.sh"

if ! [ -x "$setup_script" ]; then
    die "Unsuported platform ($PLATFORM/$PLATFORM_DISTRO)"
fi

"$setup_script"
