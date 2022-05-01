# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# enable color support of ls and also add handy aliases
 if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors     -b)"
	alias ls='ls --color=auto'
	#alias dir='dir --color=auto'
	#alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# export env
export EDITOR=vim

# set prompt
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
CYAN="\[\033[0;36m\]"
RESET="\[\033[0m\]"

if [ -n "$SSH_CLIENT" ]; then
	isssh="${RED}[ssh]${RESET}"
else
	isssh="${GREEN}[local]${RESET}"
fi

gitstatus='$(__git_ps1 "(%s)")'
export PS1="${CYAN}[\t]${RESET}\n${isssh} \u@\H: ${CYAN}\w${RESET} ${gitstatus} \n\$ "

# git-prompt
export GIT_PS1_SHOWDIRTYSTATE=true
source ~/.git-prompt.sh

# ls color

case "${OSTYPE}" in
darwin*)
	alias ls="ls -G"
	alias ll="ls -lG"
	alias la="ls -laG"
;;
linux*)
	alias ls='ls --color'
	alias ll='ls -l --color'
	alias la='ls -la --color'
;;
esac

# golang
if [ -x "`which go 2>&1`" ]; then
	export GOROOT=`go env GOROOT`
	export GOPATH=$HOME/go
	export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
fi

# git completion
source ~/.git-completion.bash

#peco setting (Ctrl-R)
export HISTCONTROL="ignoredups"
peco-history() {
    local NUM=$(history | wc -l)
    local FIRST=$((-1*(NUM-1)))

    if [ $FIRST -eq 0 ] ; then
        history -d $((HISTCMD-1))
        echo "No history" >&2
        return
    fi  

    local CMD=$(fc -l $FIRST | sort -k 2 -k 1nr | uniq -f 1 | sort -nr | sed -E 's/^[0-9]+[[:blank:]]+//' | peco | head -n 1)

    if [ -n "$CMD" ] ; then
        history -s $CMD

        if type osascript > /dev/null 2>&1 ; then
            (osascript -e 'tell application "System Events" to keystroke (ASCII character 30)' &)
        fi  
    else
        history -d $((HISTCMD-1))
    fi  
}
bind -x '"\C-r":peco-history'

#ghq setting (Ctrl-G)
function ghql() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      echo ${selected_file}
      cd ${selected_file}
      pwd
    fi
  fi
}

bind -x '"\201": ghql'
bind '"\C-g":"\201\C-m"'

# alias
alias vi=vim

alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
export AWS_RDS_HOME=/Users/grnd2472/tool/RDSCli-1.19.004
export JAVA_HOME=/Library/Java/JavaVirtualMachines/openjdk-13.0.2.jdk/Contents/Home
export GOOGLE_APPLICATION_CREDENTIALS="/Users/grnd2472/.ssh/gcp.json"
export PATH=$PATH:~/.nodebrew/current/bin/:{$AWS_RDS_HOME}/bin:$GOPATH/bin:/usr/local/bin/ghq:/Users/grnd2472/flutter/bin:/usr/local/Cellar/poppler/21.10.0/bin:/User/grnd2472/opt/anaconda3/bin
[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"


