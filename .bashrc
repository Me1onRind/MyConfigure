export HOMEBREW_NO_AUTO_UPDATE=true
export LANG="en_US.UTF-8"

#export PS1='[\u@mbp \W]\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
PATH=$PATH:/usr/local/bin

alias ll="ls -alGh"
alias grep="grep --color"

alias subl="'/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'"
alias note="cd ~/Desktop/simplenote"
alias de="cd ~/Desktop"

alias centos="ssh root@192.168.31.111"
alias not="cd ~/Desktop/simplenote"

alias g="/Users/me1onrind/gopath/bin/gocode -s -debug -sock unix -addr 127.0.0.1:37373"

# go
export GOROOT=/usr/local/go
export GOPATH=/Users/me1onrind/gopath

PATH=$PATH:$GOPATH/bin
PATH=$PATH:$GOROOT/bin
#export PATH=$PATH:/usr/local/opt/gnu-sed/bin

alias gs="cd ${GOPATH}/src"


# mysql
PATH=$PATH:/usr/local/mysql/bin
alias mysql.start="sudo /usr/local/mysql/support-files/mysql.server start"
alias mysql.status="sudo /usr/local/mysql/support-files/mysql.server status"
alias mysql.stop="sudo /usr/local/mysql/support-files/mysql.server stop"
alias mysql.restart="sudo /usr/local/mysql/support-files/mysql.server restart"
alias m="mysql -uroot -pguapi123"

# show git branch name
function git_branch {
	branch="`git branch 2>/dev/null | grep "^\*" | sed -e "s/^\*\ //"`"
	if [ "${branch}" != "" ];then
        if [ "${branch}" = "(no branch)" ];then
            branch="(`git rev-parse --short HEAD`...)"
        fi
        echo " $branch"
    fi
}
export PS1='[\u@mbp \W\[\033[01;32m\]$(git_branch)\[\033[00m\]]\$ '

alias zyb="ssh -p 8822 homework@192.168.240.235"
alias rl="ssh zenglening@relay.afpai.com"

# php
alias php7="/usr/local/php7/bin/php"

# lazygit
alias lg="lazygit"

# java
#JAVA_HOME="/usr/local/jdk-11.0.1.jdk/Contents/Home/"
#PATH=$PATH:$JAVA_HOME/bin
#CLASSPATH=$JAVA_HOME/lib/

#export CLASSPATH
#export JAVA_HOME

export PATH
