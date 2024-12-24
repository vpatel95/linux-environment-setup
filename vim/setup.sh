#!/bin/bash

HOMEDIR=~
INIT_LUA=init.lua

VIM=$HOMEDIR/.vim
NVIM_CONF=$HOMEDIR/.config/nvim
UNDOES=$VIM/.undoes

rm -rf $VIM
rm -rf $NVIM_CONF

mkdir -p $VIM
mkdir -p $NVIM_CONF
mkdir -p $UNDOES

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
