#!/bin/zsh

# Git module
autoload -Uz vcs_info
setopt prompt_subst
precmd() { vcs_info }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats '%F{green}(%b%F{red}%a%F{green})%f'

# Prompt
PROMPT='%F{yellow}%n%f %F{magenta}%~%f %F{green}${vcs_info_msg_0_}%f ❯ '

# Completion
autoload -Uz compinit; compinit
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select=1
zstyle ':completion:*' use-compctl true
zstyle :compinstall filename '/Users/vedpatel/.zshrc'
COMPLETION_WAITING_DOTS=true

source ~/.aliases
source ~/.csco/p4.aliases

export CLICOLOR=1
export GIT_EDITOR=nvim
export EDITOR=nvim
export VISUAL=nvim

### NPL Exports Start ###
export PATH=/opt/homebrew/opt/openjdk/bin:${PATH}
export PATH=/opt/homebrew/opt/unifdef/bin:$PATH
export ANTLR_ROOT=${HOME}/Library/antlr/current
alias antlr4='java -jar ${ANTLR_ROOT}/bin/antlr-4.8-complete.jar'
export BOOST_INCS="-isystem ${HOME}/Library/boost/current/include"
export BOOST_LIB_DIR=${HOME}/Library/boost/current/lib
export SWIG=/opt/homebrew/bin/swig
export UNIFDEF=/usr/bin/unifdef
export OPENSSL_INC=/opt/homebrew/Cellar/openssl@3/3.4.0/include
export PYTHON_DIR=/opt/homebrew/opt/python@3.10/Frameworks/Python.framework/Versions/3.10
export PERMISSIVE=1
### NPL Exports End ###
