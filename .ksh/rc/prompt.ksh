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
        remaining=${remaining#$prefix}
        var+="$prefix"

        case ${remaining:1:1} in
            A)    var+="\$(printf '%(%R)T')";;
            b)    var+="\${_git_status}";;
            @)    [[ ${.sh.lversion[3]:0:4} < "2020" ]] \
                  && var+="\$(printf '%(%I:%M %p)T')" \
                  || var+="\$(printf '%(%l:%M %p)T')";;  # true == before 2020, false == after 2020
            d)    var+="\$(printf '%(%a %b:%d)T')";;
            e)    var+="\$'\e'";;
            h)    [[ -z ${HOSTNAME} ]] && var+=$(hostname -s) || var+="${HOSTNAME}";;
            H)    var+=$(hostname);;
            j)    var+="\$(jobs | wc -l)";;
            l)    [[ -z ${TTY} ]] && var+="\$(basename \"\$(tty)\")" || var+="${TTY}";;
            n)    var+=$'\n';;
            p)    var+="\${_relative_pwd}" ;; # added this one to the list
            r)    var+=$'\r';;
            s)    var+="\$(basename \"\$0\")";;
            S)    var+="\${SHLVL}" ;; # added this one to the list
            t)    var+="\$(printf '%(%H:%M:%S)T')";;
            T)    var+="\$(printf '%(%I:%M:%S)T')";;
            u)    var+=$USER;;
            v)    var+="\${.sh.lversion[2]}";;
            V)    var+="\${.sh.lversion[2]} (\${.sh.lversion[1]})";;
            w)    var+="\$(pwd)";;
            W)    var+="\$(basename \"\$(pwd)\")";;
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
                   [0-7][0-7][0-7])   k=4;;
                            [0-7][0-7])   k=3;;
                                     *)   k=2;;
                  esac
                  eval n="\$'"${remaining:0:k}"'"
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
    .sh.value=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[\1]/')
}

# _relative_pwd.get is actually from polyglot.sh
# https://github.com/agkozak/polyglot
# Copyright 2017-2020 Alexandros Kozak
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

function _relative_pwd.get {

    typeset PG_DIRTRIM_ELEMENTS= PG_PWD_MINUS_HOME= PG_ABBREVIATED_PATH=
    typeset IFS

      PG_DIRTRIM_ELEMENTS="${1:-2}"

      # If root has / as $HOME, print /, not ~
      [ "$PWD" = '/' ] && .sh.value="$" && return
      [ "$PWD" = "$HOME" ] && .sh.value="~" && return

      case $HOME in
        /) PG_PWD_MINUS_HOME="$PWD" ;;            # In case root's $HOME is /
        *) PG_PWD_MINUS_HOME="${PWD#$HOME}" ;;
      esac

      if [ "$PG_DIRTRIM_ELEMENTS" -eq 0 ]; then
        [ "$HOME" = '/' ] && .sh.value="$(printf '%s' "$PWD")" && return
        case $PWD in
          ${HOME}*) .sh.value="$(printf '~%s' "$PG_PWD_MINUS_HOME")" ;;
          *) .sh.value="$(printf '%s' "$PWD")" ;;
        esac
      else
        # Calculate the part of $PWD that will be displayed in the prompt
        IFS='/'
        # shellcheck disable=SC2086
        set -- $PG_PWD_MINUS_HOME
        shift                                  # Discard empty first field preceding /

        # Discard path elements > $PG_PROMPT_DIRTRIM
        while [ $# -gt "$PG_DIRTRIM_ELEMENTS" ]; do
          shift
        done

        # Reassemble the remaining path elements with slashes
        while [ $# -ne 0 ]; do
          PG_ABBREVIATED_PATH="${PG_ABBREVIATED_PATH}/$1"
          shift
        done

        # If the working directory has not been abbreviated, display it thus
        if [ "$PG_ABBREVIATED_PATH" = "${PG_PWD_MINUS_HOME}" ]; then
          if [ "$HOME" = '/' ]; then
            .sh.value="$(printf '%s' "$PWD")"
          else
            case $PWD in
              ${HOME}*) .sh.value=$(printf '~%s' "${PG_PWD_MINUS_HOME}") ;;
              *) .sh.value="$(printf '%s' "$PWD")" ;;
            esac
          fi
        # Otherwise include an ellipsis to show that abbreviation has taken place
        else
          if [ "$HOME" = '/' ]; then
            .sh.value="$(printf '...%s' "$PG_ABBREVIATED_PATH")"
          else
            case $PWD in
              ${HOME}*) .sh.value="$(printf '~/...%s' "$PG_ABBREVIATED_PATH")" ;;
              *) .sh.value="$(printf '...%s' "$PG_ABBREVIATED_PATH")" ;;
            esac
          fi
        fi
      fi
}

# set prompt

#PS1='${RED}[\@]${OFF}${BLUE}[\l]${OFF}${YELLOW}[\S]${OFF}\n\h \$ '

case $TERM in
    # xterm and variants, set the titlebar
    xterm*) PS1='${TITLEBAR}[\u@\h][\p]${BELL}${RED}[\@]${OFF}${BLUE}[\l +\S]${OFF}${YELLOW}[\p]${OFF}${CYAN}\b${OFF}\n${GREEN}[\#]${OFF} \h \$ ' ;;
    # anything else, don't try to set the titlebar
    *) PS1='${RED}[\@]${OFF}${BLUE}[\l +\S]${OFF}${YELLOW}[\p]${OFF}${CYAN}\b${OFF}\n${GREEN}[\#]${OFF} \h \$ ' ;;
esac
