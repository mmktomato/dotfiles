## on .bashrc
# if [ -f ~/dotfiles/mybashrc ] ; then
#   . ~/dotfiles/mybashrc
# fi

export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8
export LSCOLORS='gxfxcxdxbxegedabagacad'
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'

if [[ ${PATH} != *${HOME}/bin* ]]; then
    export PATH=${HOME}/bin:${PATH}
fi

case $OSTYPE in
    linux*)  alias ls='ls -F --color=auto'
             alias rm='\mv -f --backup=numbered --target-directory ~/.mytrash'
             ;;
    darwin*) alias ls='ls -FG'
             alias rm='\gmv -f --backup=numbered --target-directory ~/.mytrash'
             ;;
esac

alias ec='emacsclient'
alias gs='git status'
alias gd='git diff'
alias mv='mv -i'
alias grep='grep --color=auto'

# git-completion
if [ -f ~/git-completion/git-completion.bash ] ; then
    . ~/git-completion/git-completion.bash
fi

# git-prompt
if [ -f ~/git-completion/git-prompt.sh ] ; then
    . ~/git-completion/git-prompt.sh

    GIT_PS1_SHOWSTASHSTATE=true
    GIT_PS1_SHOWCOLORHINTS=true

    #export PS1='\u@\h \w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] $ '
    PROMPT_COMMAND="__git_ps1 '\u@\h \w' ' \\\$ '"
else
    export PS1='\u@\h \w $ '
fi

# ndenv
if [ -d ${HOME}/.ndenv/bin ]; then
    if [[ ${PATH} != *${HOME}/.ndenv/bin* ]]; then
        export PATH=${HOME}/.ndenv/bin:${PATH}
    fi
    eval "$(ndenv init -)"
fi

# rbenv
if [ -d ${HOME}/.rbenv/bin ]; then
    if [[ ${PATH} != *${HOME}/.rbenv/bin* ]]; then
        export PATH=${HOME}/.rbenv/bin:${PATH}
    fi
    eval "$(rbenv init -)"
fi

