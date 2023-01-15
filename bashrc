# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

function reuse_ssh_agent {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        ssh_sock=$(/bin/ls $(echo "/var/folders/td/*/T/ssh*/agent.*") && true)
    else
        ssh_sock=$(/bin/ls $(echo "/tmp/ssh*/agent.*"))
    fi
    if [[ -e "$ssh_sock" ]]; then
        SSH_AUTH_SOCK=$ssh_sock; export SSH_AUTH_SOCK
    fi
}

reuse_ssh_agent
