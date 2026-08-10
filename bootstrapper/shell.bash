#!/bin/bash

function bootstrap_bash() {
    local DOTFILES=${1:-~/dotfiles}

    local GIT_COMPLETION_REMOTE_PREFIX=https://raw.githubusercontent.com/git/git/master/contrib/completion
    local GIT_COMPLETION_LOCAL_PREFIX=git-completion

    ln -s $DOTFILES/inputrc ~/.inputrc

    mkdir -p ~/.mytrash
    mkdir -p ~/$GIT_COMPLETION_LOCAL_PREFIX
    mkdir -p ~/.zsh

    curl $GIT_COMPLETION_REMOTE_PREFIX/git-completion.bash > ~/$GIT_COMPLETION_LOCAL_PREFIX/git-completion.bash
    curl $GIT_COMPLETION_REMOTE_PREFIX/git-completion.zsh > ~/$GIT_COMPLETION_LOCAL_PREFIX/git-completion.zsh
    ln -s ~/$GIT_COMPLETION_LOCAL_PREFIX/git-completion.zsh ~/.zsh
    curl $GIT_COMPLETION_REMOTE_PREFIX/git-prompt.sh > ~/$GIT_COMPLETION_LOCAL_PREFIX/git-prompt.sh

    git config --global push.default current
    git config --global --add merge.ff false
    git config --global --add pull.ff only

    mkdir -p ~/.agents
    ln -s $DOTFILES/agents/AGENTS.md ~/.agents/AGENTS.md
    ln -s $DOTFILES/agents/skills ~/.agents/skills

    mkdir -p ~/.copilot
    ln -s $DOTFILES/agents/AGENTS.md ~/.copilot/copilot-instructions.md

    mkdir -p ~/.claude
    ln -s $DOTFILES/agents/AGENTS.md ~/.claude/CLAUDE.md
    ln -s $DOTFILES/agents/skills ~/.claude/skills
}

bootstrap_bash $1

