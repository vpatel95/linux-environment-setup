#!/bin/bash

USER_SHELL=$(basename $SHELL)
RC_FILE="${HOME}/.${USER_SHELL}rc"
GITCONFIG=gitconfig
BASH_ALIASES=bash_aliases
TMUX_CONF=tmux.conf

[[ $UID == 0]] || SUDO=sudo

cd "$(dirname $0)"
BASEPATH="$PWD"

function die() {
    echo "ERROR: $*" >&2
    exit 1
}

function addLineIfMissing() {
  file="$1"; [[ -n $file ]] || die "no file specified"
  line="$2"; [[ -n $line ]] || die "no line specified"
  if ! grep -Fq "$line" "$file"; then
    echo "$line" >> "$file"
    echo "Inserted line \"$line\" into file \"$file\"" >&2
  fi
}

function setupSudo() {
    [[ -n "$SUDO" ]] && sudo -E bash -c "$(declare -f die addLineIfMissing); \
        addLineIfMissing /etc/sudoers \"$USER ALL=(ALL) NOPASSWD:ALL\""
}

function checkOperatingSystem() {
    PLATFORM="unknown"
    IN_CONTAINER="no"
    case ${OSTYPE} in
        'linux-gnu')
            PLATFORM="linux"
            . /etc/os-release
            PLATFORM_DISTRO=${ID}
            ;;
        darwin*)
            PLATFORM="darwin"
            PLATFORM_DISTRO="osx"
            ;;
        *)
            echo "OS ${OSTYPE} not supported"
            exit 1
        ;;
    esac

    # Check to see, if the environment is container
    if test -f /proc/1/cgroup && grep -q ':/docker/' /proc/1/cgroup ; then
        IN_CONTAINER="yes"
    fi

    export ${PLATFORM}
    export ${PLATFORM_DISTRO}
    export ${IN_CONTAINER}
}

function setupGoLang() {
    export PATH=${HOME}/go/bin:${PATH}
    addLineIfMissing "${RC_FILE}" "export PATH=\$HOME/go/bin:\$PATH"
}

function installGoLang() {
    # Clean up to be safe.
    sudo rm -rf ${HOME}/go/bin ${HOME}/go/pkg ${HOME}/local/src
    curl -s --fail -o /tmp/go${GO_VERSION}.${PLATFORM}-amd64.tar.gz https://dl.google.com/go/go${GO_VERSION}.${PLATFORM}-amd64.ta
r.gz
    echo "Installing go in ${LOCAL_DIR}"
    tar -C ${LOCAL_DIR} --strip-components=1 -xzf /tmp/go${GO_VERSION}.${PLATFORM}-amd64.tar.gz
    rm -f /tmp/go${GO_VERSION}.${PLATFORM}-amd64.tar.gz
    # Installation of a new Go may require rebuild.
}

function checkAndInstallGoLang() {
    #install golang
    set +e
    which go &>/dev/null
    CMD_STATUS=$?
    set -e
    if [ ${CMD_STATUS} -ne 0 ]
    then
        # go is not installed, so install it
        installGoLang
    else
        # Check which go version is installed
        set +e
        go version | grep -q ${GO_VERSION}
        CMD_STATUS=$?
        set -e
        if [ ${CMD_STATUS} -eq 0 ]
        then
            echo go ${GO_VERSION} is installed
        else
            # Since it is not ${GO_VERSION}, remove the current one, get it from google and install it.
            echo "Removing currently installed version of go."
            echo "Your password should be required for this..."
            installGoLang
        fi
    fi
}

function setLocalTimeZone() {
    # change timezone for opeserver UTs to pass
    sudo rm -f /etc/localtime
    sudo ln -s /usr/share/zoneinfo/US/Pacific /etc/localtime
}
