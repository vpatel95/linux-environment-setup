#!/bin/bash

DOCUMENTS=$HOME/Documents
DOWNLOADS=$HOME/Downloads
DESKTOP=$HOME/Desktop

## Aliases

# Git Aliases
alias gic='git clean -fdx'
alias gib='git branch --sort=-committerdate'
alias gibd='git branch -D'
alias gid='git diff'
alias gids='git diff --stat'
alias gidc='git diff --cached'
alias gil='git log --decorate --graph'
alias gila='git log --decorate --pretty=format:"%h [%an][%ad] %s" --graph'
alias gilp='git log --decorate --patch --graph'
alias gils='git log --decorate --stat --graph'
alias gis='git status'
alias gir='git reset'
alias girh='git reset --hard @{u}'
alias gip='git pull'
alias gipr='git pull --rebase'
alias giri='git rebase --interactive HEAD~'

# Command Aliases
alias sshag='eval $(ssh-agent)'
alias sshad='ssh-add '$HOME'/.ssh/github'
alias ghkey='sshag sshad'
alias rmtags='rm cscope.* tags'
alias c-scope-files='find -L . -name "*.c" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.cc" -o -name "*.hh" -o -name "*.h" -o -name "*.go" -o -name "*.py" > cscope.files'
alias vra-files='find -L . \
    -path "./build/debug" -prune -o -path "./build/third_party" -prune -o \
    -path "./build/bin" -prune -o -path "./build/etc" -prune -o \
    -path "./build/include" -prune -o -path "./build/lib" -prune -o \
    -path "./build/noarch" -prune -o -path "./build/sbin" -prune -o \
    -path "./build/share" -prune -o -path "./build/var" -prune -o \
    -path "./build/binaries" -prune -o -path "./feature_tests" -prune -o \
    -path "./third_party/dpdk*" -prune -o -path "./third_party/openvswitch*" -prune -o \
    -path "./third_party/grpc*" -prune -o -path "./node_modules" -prune -o \
    -regex ".*\.\(c\|cc\|cpp\|h\|hh\|hpp\)$" -print > cscope.files'
alias c-scope=' cscope -b -q'
alias c-tags='ctags -R -L cscope.files'
alias tags='rmtags; vra-files; c-scope; c-tags; rm cscope.files'
alias vim-help='cat ~/.vim/doc/help.txt'

# Directory Aliases
alias docs='cd $DOCUMENTS'
alias dl='cd $DOWNLOADS'

alias vi='vim'
alias vim='nvim'

alias intercept-build='intercept-build --append'

# JNPR Aliases
source ~/.jnpr.aliases

git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

PS1="(lrm) \[\e[0;93m\]\u\[\e[m\]"    # username
PS1+=" "    # space
PS1+="\[\e[0;95m\]\w\[\e[m\]"    # current directory
PS1+="\[\e[0;92m\]\$(git_branch)\[\e[m\]"    # current branch
PS1+=" "    # space
PS1+="$ "    # end prompt

export PS1;
export GIT_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim
