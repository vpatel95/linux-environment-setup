#!/bin/bash

HOMEDIR=~
INIT_LUA=init.lua

NVIM_CONF=$HOMEDIR/.config/nvim

rm -rf $NVIM_CONF
mkdir -p $NVIM_CONF

case $1 in
    nvim-ln)
        ln -s `pwd`/$INIT_LUA $NVIM_CONF/$INIT_LUA
        ln -s `pwd`/lua $NVIM_CONF/lua
        ;;
    nvim-cp)
        cp `pwd`/$INIT_LUA $NVIM_CONF/$INIT_LUA
        cp -r `pwd`/lua $NVIM_CONF/lua
        ;;
    *)
        echo "Please provide operation <nvim-ln | nvim-cp>"
        ;;
esac
