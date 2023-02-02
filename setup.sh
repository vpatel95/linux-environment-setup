#!/bin/bash -e

GO_VERSION="1.19.4"
NODEJS_MAJOR_VERSION="pub_14.x"
NODEJS_VERSION="14.16.0"

# Common location used for ccache
: ${CCACHE_DIR:=/var/cache/ccache}

USER_SHELL=$(basename $SHELL)
RC_FILE="${HOME}/.${USER_SHELL}rc"
GITCONFIG=gitconfig
BASH_ALIASES=bash_aliases
TMUX_CONF=tmux.conf

if [[ $UID != 0 ]]; then
    SUDO=sudo
fi

if [[ -z "$BASEPATH" ]]; then
  cd "$(dirname $0)"
  BASEPATH="$PWD"
else
  cd "$BASEPATH"
fi

source /etc/os-release
export DEBIAN_FRONTEND=noninteractive

function info() {
  echo "INFO: $*" >&2
}

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

function killUnattendedUpgrades() {
    while sudo pkill unattended-upgr
    do
        echo 'Unattended upgrade killed.'
        sleep 3
    done && echo 'Unattended upgrade not running.'
}

function aptGet() {
    unlockDpkg
    DEBIAN_FRONTEND=noninteractive \
        sudo -nE apt-get \
        -o Dpkg::Options::=--force-confold \
        -o Dpkg::Options::=--force-confdef \
        -y --allow-downgrades --allow-remove-essential --allow-change-held-packages "$@"
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

function setupSudo() {
    [[ -n "$SUDO" ]] && sudo -E bash -c "$(declare -f die addLineIfMissing); \
        addLineIfMissing /etc/sudoers \"$USER ALL=(ALL) NOPASSWD:ALL\""
}

function installDotFiles() {
    cp "${BASEPATH}/${GITCONFIG}" "${HOME}/.${GITCONFIG}"
    cp "${BASEPATH}/${BASH_ALIASES}" "${HOME}/.${BASH_ALIASES}"
    cp "${BASEPATH}/${TMUX_CONF}" "${HOME}/.${TMUX_CONF}"
}

function disableUnattendedUpgrades() {
    # kill it if its already running
    killUnattendedUpgrades
    # uninstall it so it can never run again
    aptGet -q remove unattended-upgrades
    # handle race condition -- just in case it was started right after it was killed
    killUnattendedUpgrades
}

function setupRepos() {
    curl -fsSL https://deb.nodesource.com/setup_${NODEJS_VERSION%%.*}.x | sudo bash -
}

function installBasicPackages() {

    if ! apt-cache pkgnames | grep -q ^sudo; then
        su -c "apt-get -q install -y sudo && echo $USER ALL=(ALL:ALL) NOPASSWD:ALL >>/etc/sudoers"
    fi

    aptGet -q install -y \
	--no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
	gnupg \
        make \
        sudo \
        unzip \
        wget
}

function aptGetUpdate() {
    aptGet -q update
}

function installPackages() {
    UBUNTU_KERNEL="$(uname -r)"
    aptGet -q install -y \
	--no-install-recommends \
	bc \
	ccache \
	cmake \
        build-essential \
        cmake \
        cscope \
        ctags \
        htop \
        libpcap-dev \
	libboost-all-dev \
	libpcap-dev \
	libssl-dev \
	liburcu-dev \
        linux-headers-${UBUNTU_KERNEL} \
        linux-tools-${UBUNTU_KERNEL} \
        linux-image-${UBUNTU_KERNEL} \
        linux-modules-${UBUNTU_KERNEL} \
        linux-modules-extra-${UBUNTU_KERNEL} \
        linux-source-${UBUNTU_KERNEL%%-*} \
        make \
	net-tools \
        nmap \
        neovim \
        net-tools \
        openssh-server \
	python2-dev
        python3-dev \
        python3-pip \
        silversearcher-ag \
        software-properties-common \
        tmux \
        traceroute \
        tree \
        vim

    sudo snap install nvim --classic
    sudo snap install ccls --classic
    sudo pip3 install scan-build
}

function installLLVM() {
    llvm_version=${1:-15}
    unlockDpkg
    DEBIAN_FRONTEND=noninteractive \
        sudo ${BASEPATH}/llvm.sh $llvm_version all
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

function setupCcache() {
    # Remove old ccache directory
    rm -rf $HOME/.cache/ccache
    # Set up shared ccache directory
    sudo mkdir -p "${CCACHE_DIR}/tmp"
    sudo chgrp adm "${CCACHE_DIR}"
    sudo chmod oug+rwxs "${CCACHE_DIR}" "${CCACHE_DIR}/tmp"
    ccache --set-config=umask=002
    ccache --set-config=max_size=${CCACHE_MAXSIZE:-16G}
    ccache --set-config=cache_dir="${CCACHE_DIR}"
    ccache --set-config=temporary_dir="${CCACHE_DIR}/tmp"
    ccache --set-config=log_file=syslog
    if [[ -x /usr/sbin/rsyslogd ]]; then
        sudo bash -c "cat  >  /etc/rsyslog.d/100-ccache-conf << EOF
# log ccache to file
:programname, isequal, "ccache"         /var/log/ccache
# remove from syslog
& ~
EOF
"
        sudo systemctl restart rsyslog
    fi
    ccache --show-stats
    ccache_on="sudo ln -sf /usr/bin/ccache /usr/local/bin/gcc && sudo ln -sf /usr/bin/ccache /usr/local/bin/g++ && sudo ln -sf /usr/bin/ccache /usr/local/bin/cc && sudo ln -sf /usr/bin/ccache /usr/local/bin/c++"
    ccache_off="sudo ln -sf /usr/bin/gcc /usr/local/bin/gcc && sudo ln -sf /usr/bin/g++ /usr/local/bin/g++ && sudo ln -sf /usr/bin/c /usr/local/bin/cc && sudo ln -sf /usr/bin/c++ /usr/local/bin/c++"
    addLineIfMissing "${RC_FILE}" "alias ccache-on='${ccache_on}'"
    addLineIfMissing "${RC_FILE}" "alias ccache-off='${ccache_off}'"
    # Turn it on.
    $SHELL -c "$ccache_on"
}

function unlockDpkg() {
    apt_pid=$(sudo apt-get -q install BOGUS_PACKAGE 2>&1 | sed -ne 's:.* held by process \([0-9]*\) .*:\1:p')
    if [[ -n "$apt_pid" ]]; then
        echo "KILLING PROCESS HOLDING DPKG LOCK: $apt_pid"
        sudo kill $apt_pid
        while ps $apt_pid &>/dev/null; do
            echo "Not dead yet..."
            sleep 1
	done
        echo "DEAD: $apt_pid"
    fi
}

function aptGet() {
    unlockDpkg
    DEBIAN_FRONTEND=noninteractive \
        sudo -nE apt-get \
        -o Dpkg::Options::=--force-confold \
        -o Dpkg::Options::=--force-confdef \
        -y --allow-downgrades --allow-remove-essential --allow-change-held-packages "$@"
}

checkOperatingSystem
setupSudo
installDotFiles
disableUnattendedUpgrades
setupRepos
installBasicPackages
aptGetUpdate
installPackages
installLLVM 15

# prepareLocalBin
#
#check if golang is installed, if no, install
checkAndInstallGoLang
setupGoLang
#cache c/c++ compilation for speed
setupCcache

# gdb 12.9 that come with Ubuntu 22.04 crashes.
# Need to get the devel release
if ! apt list --installed gdb 2>/dev/null | grep -q '^gdb/'; then
  # install dependencies
  aptGet -q install \
    --no-install-recommends \
      libbabeltrace1 \
      libdebuginfod1 \
      libipt2 \
      libsource-highlight4v5 \
      libdebuginfod-common \
      libsource-highlight-common
  wget -O /tmp/libgmp10.deb https://svl-artifactory.juniper.net/artifactory/cn2-static-dev/libgmp10_6.2.1+dfsg1-1ubuntu2_amd64.deb
  wget -O /tmp/gdb.deb https://svl-artifactory.juniper.net/artifactory/cn2-static-dev/gdb_12.1-3ubuntu2_amd64.deb
  sudo dpkg --install /tmp/libgmp10.deb /tmp/gdb.deb
fi

# update .gitconfig
# 1. user.name, user.email
# 2. recommended configs (credstore)
# 3. git aliases
setLocalTimeZone
