#!/bin/bash

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files for examples

# mwilson (msw@cox.net)

# Source global definitions
#if [ -f /etc/bashrc ]; then
#	. /etc/bashrc
#fi

# User specific aliases and functions

export BC_ENV_ARGS=~/.bcrc
#export EDITOR="/usr/local/bin/mate -w"
export EDITOR="/usr/local/bin/bbedit -w"
export LESS='-giMR -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
export MOZ_PRINTER_NAME=laser
export PAGER="less"
export PRINTER=laser
export VISUAL=vim
export LESSOPEN="|/Users/mwilson/bin/lesspipe.sh %s"
export TODOTXT_DEFAULT_ACTION=ls

# export MAIL=/var/spool/mail/$USER
# export PKG_CONFIG_PATH=/home/$USER/.pkgconfig
# export MANPATH=:/opt/openbox3/man/:~/man
# export ENV=~/.bashrc

# set our umask... this gives us 644
# if we wanted 640, we'd use 'umask 026', for 600, we'd use 'umask 066'

# umask 022

# Below here is stuff that only gets used if the shell is an
# interactive one...

if [ "$PS1" ]; then

function prompt
  {
  case $TERM in
      xterm* | rxvt* | Eterm*)
          local TITLEBAR='\[\033]0;[ \u @ \h ] [ `short_path` ]\007\]'
          ;;
      *)
          local TITLEBAR=''
          ;;
  esac

local RED="\[\033[0;31m\]"
local BLUE="\[\033[0;36m\]"
local YELLOW="\[\033[0;33m\]"
local OFF="\[\033[0m\]"

local CURR_TTY=$(tty | sed -e "s:/dev/::")

PS1="${TITLEBAR}${RED}[\$(date +'%l:%M %p')]${BLUE}[${CURR_TTY}]${YELLOW}[\$(short_path)]${OFF}\n\h \$ "
PS2='> '
PS4='+ '
  }

    # short_path truncates $PWD to the last two elements, and prefixes an
    # ellipsis mark and/or arrow if necessary
    function short_path() { echo $PWD \
                                | rev \
                                | awk -F/ '{ if (NF>3) {A=$1"/"$2"/.."} else
                                                if (NF==3) {A=$1"/"$2"/"} else
                                                if (NF<3) {A=$1"/"$2}
                                                      print (length(A)>45 ? substr(A,1,45)" <<" : A) }' \
                                | rev; }

    # neat functions to have

    function spell()    { /usr/bin/ispell -S -x <$(echo "$@"); }
    function psgrep()   { ps aux | grep $1 | grep -v grep; }

    function bold()      { tput smso; }
    function unbold()    { tput rmso; }

    # rot13 takes as input either stdin, or a file.
    function rot13() {
        if [ $# = 0 ] ; then
                tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]"
        else
                tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" < $1
        fi
    }

    # watch steps on /usr/bin/watch, from the procps package, which I didn't
    # even know existed before now, so who cares? ^_^
    function watch() {
        if [ $# -ne 1 ] ; then
                tail -f nohup.out
        else
                tail -f $1
        fi
    }

    # just-in-case csh/tcsh compatability
    alias unsetenv=unset
    function setenv() {
        if [ $# -ne 2 ] ; then
                echo "setenv: Too few arguments"
        else
                export $1="$2"
        fi
    }

    # can't do it as an alias because of the parameter, so...
    function dvdburniso() {
        if [ $# -ne 1 ] ; then
                echo "dvdburniso: Wrong number of arguments"
        else
                growisofs -dvd-compat -speed=8 -Z /dev/dvd=$1
        fi
    }
    # useful options...

    shopt -s checkwinsize           # inform us if the window changes
    shopt -s cdspell                # correct minor spelling errors
    shopt -s cmdhist                # turn multi-line commands into single line
    shopt -s histappend             # append to history, not overwrite
    set -o ignoreeof                # ignore ^d for logout
    #set -o vi                      # vi-style command line editing
    set -o emacs                    # emacs-style command line editing
    #eval $(lesspipe)                # *pipe fast, *file slow and pretty

    # other useful settings

#   export CDPATH=.:~:~/src:~/pictures:/usr/src:/usr/local/src:/:/mnt
    export HISTCONTROL="ignoreboth"
    export HISTIGNORE="[bf]g:exit:ls:cd:mutt"

    # set up mail notification, use $MAIL if we don't have support from
    # procmail for lastfromfile

#    if [ -f ~/.procmail/lastfromfile ]; then
#        MAILPATH=~/.procmail/lastfromfile'?You have new mail.'
#    else
#        MAILPATH=$MAIL'?You have new mail.'
#    fi
#    export MAILPATH

    # enable color support for ls and add aliases

    if [ "$TERM" != "dumb" ]; then
#        eval $(dircolors -b)        # set up colors for ls
        alias ls='ls -GF'
        alias dir='ls -GFCl'
        alias vdir='ls -GFl'
    fi

    # other aliases I like

    alias dvdburn='growisofs -dvd-compat -speed=8 -Z /dev/dvd -dvd-video'

    alias ll='ls -lG'
    alias la='ls -AG'
    alias l='ls -CFG'
    # alias br='ssh mailhost br -x /dev/ttyS1'
    alias bt='bittorrent-curses --max_upload_rate 10'
    alias cdb='cd $OLDPWD'
    alias mutt="mutt -y"
    alias mv='mv -i'
    alias rm='rm -i'
    alias plcs='vncviewer -via plserver.homeip.net -passwd ~/.vnc/pilgrim'
    alias pu='pushd'
    alias po='popd'
    alias pr1='enscript -1 -G -j -M letter -R'
    alias pr2='enscript -2 -G -j -M letter -r'
    alias rebuildLS='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user'
    alias t='todo.sh -ctfn'

    # start up bash completion
    # note... Debian does it in /etc/bash.bashrc, which is stupid, and
    # a complete Debian-ism.

    # Favor a local version over one that might come with the shell
    # this is safe because bash_completion checks to make sure it's not
    # being sourced as ~/.bash_completion before it sources local
    # completions.  This does mean that if there are local completions,
    # that's ALL you get if you do things this way.

#    if [ -f ~/.bash_completion ]; then
#        BASH_COMPLETION=~/.bash_completion
#        . ~/.bash_completion
#    elif [ -f /etc/bash_completion ]; then
#       . /etc/bash_completion
#    fi

    # set the shell prompt, make sure we don't try to use terminal controls if they're not
    # supported.  Allow for a quiet prompt if the invoker specified one.

    if [ "$0" = "term_tiny" ] || [ "$TERM" = "dumb" ]; then
       PS1='\h \$ '
    else
       prompt
    fi
fi

#$Id: .bashrc,v 1.23 2005/02/15 08:09:56 mwilson Exp mwilson $

# vim: nu tw=0 ts=4

# Created by `userpath` on 2021-02-06 17:26:28
export PATH="$PATH:/Users/mwilson/.local/bin"

# Created by `userpath` on 2021-02-11 02:58:07
export PATH="$PATH:/Users/mwilson/Library/Python/3.8/bin"
