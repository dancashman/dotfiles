export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH

###########################
# ALIASES
###########################

alias ls='ls -lhaG'
alias ll='ls -hl'
alias search=grep
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias dev='cd ~/Development'
alias removeDS='find . -type f -name ".DS_Store" -exec rm {} \;'

# Project directories
alias ngc='cd ~/Development/natgeo/channel/'

# git commamands simplified
alias gst='git status'
alias gco='git checkout'
alias gci='git commit'
alias grb='git rebase'
alias gbr='git branch'
alias glg='git log --date-order --all --graph --format="%C(green)%h%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'
alias glg2='git log --date-order --all --graph --name-status --format="%C(green)%H%Creset %C(yellow)%an%Creset %C(blue bold)%ar%Creset %C(red bold)%d%Creset%s"'

# Tomcat
alias start_tomcat='/usr/local/Cellar/tomcat/7.0.47/libexec/bin/startup.sh'
alias stop_tomcat='/usr/local/Cellar/tomcat/7.0.47/libexec/bin/shutdown.sh'

# lock computer
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

# simple ip
alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\ -f2'
# more details
alias ip1="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ &amp;&amp; print $1'"
# external ip
alias ip2="curl -s http://www.showmyip.com/simple/ | awk '{print $1}'"

# grep with color
alias grep='grep --color=auto'

# refresh shell
alias reload='source ~/.bash_profile'

# processes
#alias ps='ps -ax'

# Vagrant
alias vussh='vagrant up && vagrant ssh'

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

###########################
# ENVIRONMENT VARIABLES
###########################

# BIN Local
BIN_LOCAL='~/bin'
export PATH=${PATH}:${BIN_LOCAL}

# Java
JAVA_HOME='/Library/Java/Home'
export PATH=${PATH}:${JAVA_HOME}/bin

# Maven
export M3_HOME='/usr/local/Cellar/maven/3.2.1/libexec'
export M3=${M3_HOME}/bin
export MAVEN_OPTS='-Xms1024m -Xmx1024m -XX:PermSize=256m -XX:MaxPermSize=512m'
export PATH=${PATH}:${M3}

NPM='/usr/local/share/npm/bin'
export PATH=${PATH}:${NPM}

#Node
NODE_PATH='/usr/local/lib/node_modules'
export PATH=${PATH}:${NODE_PATH}

# Virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development
source /usr/local/bin/virtualenvwrapper.sh

# LESSC instead of the ruby version
export lessc=/usr/local/share/npm/bin/lessc

# nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

eval "$(grunt --completion=bash)"

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
