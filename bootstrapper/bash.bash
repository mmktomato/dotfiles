#!/bin/bash

function bootstrap_bash() {
    local DOTFILES=${1:-~/dotfiles}

    local GIT_COMPLETION_REMOTE_PREFIX=https://raw.githubusercontent.com/git/git/master/contrib/completion
    local GIT_COMPLETION_LOCAL_PREFIX=git-completion

    ln -s $DOTFILES/inputrc ~/.inputrc

    mkdir ~/.mytrash
    mkdir ~/$GIT_COMPLETION_LOCAL_PREFIX

    curl $GIT_COMPLETION_REMOTE_PREFIX/git-completion.bash > ~/$GIT_COMPLETION_LOCAL_PREFIX/git-completion.bash
    curl $GIT_COMPLETION_REMOTE_PREFIX/git-prompt.sh > ~/$GIT_COMPLETION_LOCAL_PREFIX/git-prompt.sh

    git config --global push.default current
}

bootstrap_bash $1

