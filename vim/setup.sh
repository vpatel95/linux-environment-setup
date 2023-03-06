#!/bin/bash

HOMEDIR=~
VIMRC=.vimrc
OLD_VIM=old.vim
INIT_LUA=init.lua
COC_SETTING=coc-settings.json
CSCOPE=cscope_maps.vim

VIM=$HOMEDIR/.vim
NVIM_CONF=$HOMEDIR/.config/nvim

PLUG=$VIM/.vim_plug
PACK=$NVIM_CONF/.vim_pack
UNDOES=$VIM/.undoes

case $1 in
    vim)
        rm -rf $VIM

        mkdir -p $VIM
        mkdir -p $PLUG
        mkdir -p $UNDOES

        cp $VIMRC $HOMEDIR/$VIMRC

        sh -c 'curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

        cp $CSCOPE $VIM/$CSCOPE

        vim +PlugInstall +qall
        ;;
    nvim)
	rm -rf $VIM
        rm -rf $NVIM_CONF

        mkdir -p $VIM
        mkdir -p $NVIM_CONF
        mkdir -p $UNDOES

        cp $OLD_VIM $NVIM_CONF/$OLD_VIM
        cp $INIT_LUA $NVIM_CONF/$INIT_LUA
        cp -r ./lua $NVIM_CONF
        cp $COC_SETTING $NVIM_CONF/$COC_SETTING

        cp $CSCOPE $VIM/$CSCOPE
        ;;
    *)
        echo "Please provide operation <vim | nvim>"
        ;;
esac
