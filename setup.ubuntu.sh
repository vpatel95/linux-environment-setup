set -e

BASEPATH=$(dirname $0)

source ${BASEPATH}/common-setup.sh

source /etc/os-release

function setupUbuntuRepos() {
    curl -fsSL https://deb.nodesource.com/setup_${NODEJS_VERSION%%.*}.x | sudo bash -

    sudo add-apt-repository ppa:neovim-ppa/stable -y
}

function aptGetUpdate() {
    sudo apt-get -q update
}

function setupRepos() {
    setupUbuntuRepos
}

function installBasicPackages() {
    export DEBIAN_FRONTEND=noninteractive

    if ! apt-cache pkgnames | grep -q ^sudo; then
        su -c "apt-get -q install -y sudo && echo $USER ALL=(ALL:ALL) NOPASSWD:ALL >>/etc/sudoers"
    fi

    sudo apt-get -q install -y --no-install-recommends \
        apt-transport-https \
        ca-certificates \
        curl \
        git \
        make \
        sudo \
        software-properties-common \
        unzip \
        wget
}

function installPackages() {
    export DEBIAN_FRONTEND=noninteractive

    sudo apt-get -q install -y --no-install-recommends \
        build-essential \
        cmake \
        cscope \
        ctags \
        htop \
        libpcap-dev \
        linux-headers-${UBUNTU_KERNEL} \
        linux-tools-${UBUNTU_KERNEL} \
        linux-image-${UBUNTU_KERNEL} \
        linux-modules-${UBUNTU_KERNEL} \
        linux-modules-extra-${UBUNTU_KERNEL} \
        make \
        nmap \
        neovim \
        net-tools \
        openssh-server \
        python3-dev \
        python3-pip \
        silversearcher-ag \
        tmux \
        traceroute \
        tree \
        vim
}

function installDotFiles() {
    cp "${BASEPATH}/${GITCONFIG}" "${HOME}/.${GITCONFIG}"
    cp "${BASEPATH}/${BASH_ALIASES}" "${HOME}/.${BASH_ALIASES}"
    cp "${BASEPATH}/${TMUX_CONF}" "${HOME}/.${TMUX_CONF}"
    cp "${BASEPATH}/${USER_SHELL}rc" ${RC_FILE}
}

installDotFiles

checkOperatingSystem

setupSudo

installBasicPackages

setupRepos

aptGetUpdate

installPackages

checkAndInstallGoLang
setupGoLang

setLocalTimeZone
