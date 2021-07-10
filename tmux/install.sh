#!/bin/bash

TYPE="$1"

case $TYPE in
    1404)
        cp tmux.conf.1404 ~/.tmux.conf
        ;;
    1604)
        cp tmux.conf.1604 ~/.tmux.conf
        ;;
    1804)
        cp tmux.conf.1804 ~/.tmux.conf
        ;;
    2004)
        cp tmux.conf.2004 ~/.tmux.conf
        ;;
    mac)
        cp tmux.conf.mac ~/.tmux.conf
        ;;
    powerline)
        cp tmux.conf.powerline ~/.tmux.conf
        ;;
esac
