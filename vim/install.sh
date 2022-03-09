#!/bin/bash

HOMEDIR=~
VIMRC=.vimrc
INIT_VIM=init.vim
COC_SETTING=coc-settings.json

VIM=$HOMEDIR/.vim
NVIM_CONF=$HOMEDIR/.config/nvim

BUNDLE=$VIM/.vim_bundle
PLUG=$VIM/.vim_plug

UNDOES=$VIM/.vim_undoes
operation=$1

case $1 in
    install)
        rm -rf $VIM
        rm -rf $NVIM_CONF

        mkdir -p $NVIM_CONF

        mkdir -p $BUNDLE
        mkdir -p $PLUG

        mkdir -p $UNDOES

        cp -r ./ $VIM

        cp $VIMRC $HOMEDIR/$VIMRC
        cp $INIT_VIM $NVIM_CONF/$INIT_VIM
        cp $COC_SETTING $NVIM_CONF/$COC_SETTING

        git clone https://github.com/VundleVim/Vundle.vim.git $BUNDLE/Vundle.vim
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

        cp -r scripts/* $BUNDLE/
        cp -r scripts/* $PLUG/

        vim +PluginInstall +qall!
        nvim +PlugInstall +qall!
        ;;

    update)
        cp -r ./ $VIM
        cp $VIMRC $HOMEDIR/$VIMRC
        cp -r scripts/* $PLUG/
        vim +PlugInstall +qall!
        ;;

    *)
        echo "Please provide operation <install | update>"
        ;;
esac
