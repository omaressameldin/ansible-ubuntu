# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# set env paths
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH="$PATH:$HOME/flutter/bin"
export ANDROID_HOME=/opt/android-sdk-linux
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"
# some more ls aliases
alias ll='ls -l'
#alias la='ls -A'
alias l='ls -CF'

alias mine='sudo chown -R $USER'
alias clip='xclip -selection clipboard'
alias screenshot="scrot -e 'mv $f ~/Pictures/$f' -s"
bind -x '"\C-k":clear && printf "\e[3J"'

# settings alias
alias settings='env XDG_CURRENT_DESKTOP=GNOME gnome-control-center'
# logout alias
alias logout='sudo pkill -u $USER'

alias display_available='xrandr | grep -w "connected"'
alias display_disc='xrandr --auto'

display_con() {
  if [ -n "$3" ]; then
    xrandr --output DP-"$1" --mode "$2" --rate 60
  else
    xrandr --output DP-"$1" --mode  2560x1440 --rate 60
  fi
  xrandr --output eDP-1-1 --left-of DP-"$1"
}


# git aliases
alias g_cur_branch="git branch | sed -n '/\* /s///p'"

g_rename_branch() {
oldBranchName="$(g_cur_branch)"
git branch -m $oldBranchName "$1"
git push origin :"$oldBranchName" 
git push --set-upstream origin "$1"
}

# docker aliasess
alias d_kill_all='docker stop $(docker ps -qa)'
alias d_die='docker system prune -a'
alias rails_c='docker exec -it rails rails c'
alias d_logs='docker logs -f'
alias tdo_dev='tdo_go && ansible-playbook playbooks/development.yml'
alias tdo_stg='tdo_go && ansible-playbook playbooks/staging.yml -i inventory.yml -u deploy'
alias tdo_go='cd ~/Taledo/apps'

d_go() {
    docker exec -it "$1" bash
}

d_ip() {
 docker inspect -f '{{ .NetworkSettings.IPAddress }}' "$1"
}
# python aliases
alias python='python3'
alias pip='pip3'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# Set LS_COLORS environment by Deepin
if [[ ("$TERM" = *256color || "$TERM" = screen* || "$TERM" = xterm* ) && -f /etc/lscolor-256color ]]; then
    eval $(dircolors -b /etc/lscolor-256color)
else
    eval $(dircolors)
fi


export PATH="/home/omaressameldin/.local/bin:/home/omaressameldin/bin:/opt/GitHub Desktop:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/usr/local/go/bin:/home/omaressameldin/flutter/bin"
alias fnm=/home/omaressameldin/.fnm/fnm
eval "`fnm env --multi`"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "/home/omaressameldin/.gvm/scripts/gvm" ]] && source "/home/omaressameldin/.gvm/scripts/gvm"
