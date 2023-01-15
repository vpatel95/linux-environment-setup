set -e

source ${BASEPATH}/common-setup.sh

function installBasicPackages() {
    if ! which brew &>/dev/null; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

function installPackages() {
    packages=(git bash bash-completion)
    brew install ${packages[@]} || brew upgrade ${packages[@]}
}
