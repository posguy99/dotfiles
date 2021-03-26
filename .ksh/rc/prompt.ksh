#!/usr/bin/env ksh

# fancy prompt

# dicipline finction for setting PS1.  ksh93u+ includes a slightly different one from dgk
# I use this one because I didn't know about the other one
# https://blog.fpmurphy.com/2016/08/bash-like-customizable-prompt-in-korn-shell.html

function PS1.set
{
    typeset prefix remaining=${.sh.value} var= n= k=
    set -A .sh.lversion ${.sh.version}

    while [[ $remaining ]]
    do
        prefix=${remaining%%'\'*}
        remaining=${remaining#"$prefix"}
        var+=$prefix

        case ${remaining:1:1} in
            A)    var+="\$(printf '%(%R)T')";;
            b)    var+="\${_git_status}";;
            @)    ((.sh.version < 20200101)) \
                  && var+="\$(printf '%(%I:%M %p)T')" \
                  || var+="\$(printf '%(%l:%M %p)T')";;  # true == before 2020, false == after 2020
            d)    var+="\$(printf '%(%a %b:%d)T')";;
            e)    var+="\$'\e'";;
            h)    [[ -z ${HOSTNAME} ]] && var+=$(hostname -s) || var+="${HOSTNAME}";;
            H)    var+=$(hostname);;
            j)    var+="\$(jobs | wc -l)";;
            l)    [[ -z ${TTY} ]] && var+=$(basename "$(tty)") || var+="${TTY}";;
            n)    var+=$'\n';;
            p)    var+="\${_relative_pwd}" ;; # added this one to the list
            r)    var+=$'\r';;
            s)    var+=$(basename "$0") ;;
            S)    var+="\${SHLVL}" ;; # added this one to the list
            t)    var+="\$(printf '%(%H:%M:%S)T')";;
            T)    var+="\$(printf '%(%I:%M:%S)T')";;
            u)    var+=$USER;;
            v)    var+=${.sh.lversion[2]} ;;
            V)    var+="${.sh.lversion[2]} (${.sh.lversion[1]})";;
            w)    var+="\$PWD";;
            W)    var+="\$(basename \"\$PWD\")";;
          '#')    var+=!;;
            !)    var+=!;;
          '$')    if (( $(id -u) == 0 ))
                  then
                      var+='#'
                  else
                      var+='$'
                  fi;;
          '\')    var+='\\';;
      '['|']')    ;;
        [0-7])    case ${remaining:1:3} in
                   [0-7][0-7][0-7] )  k=4;;
                        [0-7][0-7]*)  k=3;;
                                  *)  k=2;;
                  esac
                  eval "n=\$'${remaining:0:k}'"
                  var+=$n
                  remaining=${remaining:k}
                  continue ;;
           "")    ;;
            *)    var+='\'${remaining:0:2};;
        esac
        remaining=${remaining:2}
    done
    .sh.value=$var
}

# for now all it does is get the current branch, if there is one.
function _git_status.get
{
    typeset branch commit return
    branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/')
    [[ -n "$branch" ]] && commit=$(git rev-parse --short HEAD 2> /dev/null) && return="${branch%]}@${commit}]"
    .sh.value=${return}
}

# Discipline function for relative present working directory
# by Martijn Dekker <martijn@inlv.org> 2020-08-09; public domain
function _relative_pwd.get
{
    typeset del ellip=$'\u2026' v=$PWD keep=*/*   # add /* for each element to keep
    ((${#ellip}==1)) || ellip='...'
    [[ ($v == "$HOME" || $v == "$HOME"/*) && $HOME != / ]] && v=\~${v#"$HOME"}
    del=${v%/$keep}/
    [[ $v == /*/$keep ]] && v=$ellip/${v#"$del"}
    [[ $v == \~/*/$keep ]] && v=\~/$ellip/${v#"$del"}
    .sh.value=$v
}

# set prompt

#PS1='${RED}[\@]${OFF}${BLUE}[\l]${OFF}${YELLOW}[\S]${OFF}\n\h \$ '

case $TERM in
    # xterm and variants, set the titlebar
    xterm*) PS1='${TITLEBAR}[\u@\h] [\l +\S] [\p]${BELL}${RED}[\@]${OFF}${BLUE}[\l +\S]${OFF}${YELLOW}[\p]${OFF}${CYAN}\b${OFF}\n${GREEN}[\#]${OFF} \h \$ ' ;;
    # xterm*) PS1='${TITLEBAR}[\u@\h][\p]${BELL}${RED}[\@]${OFF}${BLUE}[\l +\S]${OFF}${YELLOW}[\p]${OFF}${CYAN}\b${OFF}\n${GREEN}[\#]${OFF} \h \$ ' ;;
    # anything else, don't try to set the titlebar
    *) PS1='${RED}[\@]${OFF}${BLUE}[\l +\S]${OFF}${YELLOW}[\p]${OFF}${CYAN}\b${OFF}\n${GREEN}[\#]${OFF} \h \$ ' ;;
esac
