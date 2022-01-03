#!/bin/bash

TYPE="$1"

case $TYPE in
    ubuntu)
        cp tmux.conf.ubuntu ~/.tmux.conf
        ;;
    mac)
        cp tmux.conf.mac ~/.tmux.conf
        ;;
    powerline)
        cp tmux.conf.powerline ~/.tmux.conf
        ;;
esac
