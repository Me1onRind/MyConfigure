export HOMEBREW_NO_AUTO_UPDATE=true
export LANG="en_US.UTF-8"
export TERM=xterm

#export PS1='[\u@mbp \W]\$ '
# Make bash check its window size after a process completes
shopt -s checkwinsize

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


# lazygit
alias lg="lazygit"

# java
#JAVA_HOME="/usr/local/jdk-11.0.1.jdk/Contents/Home/"
#PATH=$PATH:$JAVA_HOME/bin
#CLASSPATH=$JAVA_HOME/lib/

#export CLASSPATH
#export JAVA_HOME

export PATH
