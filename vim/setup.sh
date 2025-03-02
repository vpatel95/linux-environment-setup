#!/bin/bash

BASEPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
HOMEDIR=~
INIT_LUA=init.lua

NVIM_CONF=$HOMEDIR/.config/nvim
NVIM_UNDOES=$NVIM_CONF/.undoes

case $1 in
    nvim-ln)
        rm -rf $NVIM_CONF
        ln -s ${BASEPATH} $NVIM_CONF
        mkdir -p $NVIM_UNDOES
        ;;
    nvim-cp)
        rm -rf $NVIM_CONF
        rsync -a --exclude '.git*' ${BASEPATH}/ ${NVIM_CONF}
        mkdir -p $NVIM_UNDOES
        ;;
    *)
        echo "Usage : "
        echo "    bash $0 <nvim-ln | nvim-cp>"
        ;;
esac
