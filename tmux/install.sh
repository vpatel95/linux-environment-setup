#!/bin/bash

TYPE="$1"

case $TYPE in
    1404)
        cp tmux.conf.1404 ~/.tmux.conf
        ;;
    1604)
        cp tmux.conf.1604 ~/.tmux.conf
        ;;
    2004)
        cp tmux.conf.2004 ~/.tmux.conf
        ;;
    powerline)
        cp tmux.conf.powerline ~/.tmux.conf
        ;;
