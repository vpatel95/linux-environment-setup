#!/bin/bash

DOCUMENTS=$HOME/Documents
DOWNLOADS=$HOME/Downloads
DESKTOP=$HOME/Desktop

## Aliases

# Git Aliases
alias gic='git clean -fdx'
alias gib='git branch'
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
alias tags='rmtags; find . -name "*.c" -o -name "*.cpp" -o -name "*.hpp" -o -name "*.cc" -o -name "*.hh" -o -name "*.h" -o -name "*.go" -o -name "*.py" > cscope.files; cscope -b; rm cscope.files; ctags -R --exclude=*.js'
alias vim-help='cat ~/.vim/doc/help.txt | less'

# Directory Aliases
alias docs='cd $DOCUMENTS'
alias dl='cd $DOWNLOADS'

alias vim='nvim'

git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if [ -z $ZSH_VERSION ]; then
    setopt PROMPT_SUBST
    export PROMPT='%F{red}%n %F{magenta}%2~ %F{green}$(git_branch)%f $ '
else
    PS1="(fdv) \[\e[0;93m\]\u\[\e[m\]"    # username
    PS1+=" "    # space
    PS1+="\[\e[0;95m\]\w\[\e[m\]"    # current directory
    PS1+="\[\e[0;92m\]\$(git_branch)\[\e[m\]"    # current branch
    PS1+=" "    # space
    PS1+="$ "    # end prompt

    export PS1;
fi

export GIT_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim
