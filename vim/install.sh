#!/bin/bash

HOMEDIR=~
VIMRC=.vimrc
VIM=$HOMEDIR/.vim
PLUG=$VIM/.vim_plug
UNDOES=$VIM/.vim_undoes
operation=$1

case $1 in
    install)
        rm -rf $VIM
        mkdir -p $BUNDLE
        mkdir -p $UNDOES
        cp -r ./ $VIM
        cp $VIMRC $HOMEDIR/$VIMRC
        curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        cp -r scripts/* $PLUG/
        vim +PlugInstall +qall!
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
