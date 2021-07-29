#!/bin/bash

HOMEDIR=~
VIMRC=.vimrc
VIM=$HOMEDIR/.vim
BUNDLE=$VIM/.vim_bundle
UNDOES=$VIM/.vim_undoes
operation=$1

case $1 in
    install)
        rm -rf $VIM
        mkdir -p $BUNDLE
        mkdir -p $UNDOES
        cp -r ./ $VIM
        cp $VIMRC $HOMEDIR/$VIMRC
        git clone https://github.com/VundleVim/Vundle.vim.git $BUNDLE/Vundle.vim
        cp -r scripts/* $BUNDLE/
        vim +PluginInstall +qall!
        # cd $BUNDLE/youcompleteme
        # python3 install.py --clang-completer --clangd-completer
        ;;

    update)
        cp -r ./ $VIM
        cp $VIMRC $HOMEDIR/$VIMRC
        cp -r scripts/* $BUNDLE/
        vim +PluginInstall +qall!
        ;;

    *)
        echo "Please provide operation <install | update>"
        ;;
esac
