# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias m=more
alias tn=telnet
alias l='ls -alF'
alias la='ls -al'
alias lm='ls -al|more'
alias lh='ls -alh'
alias c=clear
alias h=history
alias ps='ps -w'
alias ldir='ls -al|grep ^d'
