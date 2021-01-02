LANG="en_US.UTF-8"

alias lg='lazygit' # https://github.com/jesseduffield/lazygit
alias grep='grep --color'
alias ll='ls -alFG'

function git_branch {
    branch="`git branch 2>/dev/null | grep '^\*' | sed -e 's/^\*\ //'`"
    if [ "${branch}" != '' ];then
        if [ "${branch}" = '(no branch)' ];then
            branch='(`git rev-parse --short HEAD`...)'
        fi
        echo " $branch"
    fi
}

export PS1='[\u@debian \W\[\033[01;32m\]$(git_branch)\[\033[00m\]]\$ '

PATH=$PATH:/usr/local/vim/bin/ # vim

# go
export GOROOT=/usr/local/go
export GOPATH=/gopath
PATH=$PATH:$GOROOT/bin
PATH=$PATH:$GOPATH/bin

# node, npm
export PATH=$PATH:/usr/local/node/bin

export PATH
