#!/usr/bin/env ksh

# set up home/end/pgup/pgdn/fwddel
# this is the RHEL way of defining keys
# apparently almost everyone else uses the keybind thing from the Bolsky book
# but you can't see what that does in the environment

# removed the below, I misread that, it is obviously meant for vi mode
#    $'\030')  .sh.edchar=$'\001\013';;  # ctrl-x = delete line according to New Kornshell book, Mac uses ^U

keybd_trap () {
  case ${.sh.edchar} in
    $'\e[1~') .sh.edchar=$'\001';;      # Home = beginning-of-line
    $'\e[4~') .sh.edchar=$'\005';;      # End = end-of-line
    $'\e[5~') .sh.edchar=$'\e>';;       # PgUp = history-previous
    $'\e[6~') .sh.edchar=$'\e<';;       # PgDn = history-next
    $'\e[3~') .sh.edchar=$'\004';;      # Delete = delete-char
  esac
}
trap keybd_trap KEYBD

# from Bolsky, page 98

# typeset -A Keytable
# trap 'eval "${Keytable[${.sh.edchar}]}"' KEYBD
# unset -f keybind
# function keybind # key [action]
# {
#     typeset key=$(print -f "%q" "$2")
#     case $# in
#         2)  Keytable[$1]=' .sh.edchar=${.sh.edmode}'"$key"
#             ;;
#         1)  unset Keytable[$1]
#             ;;
#         *)  print -u2 "Usage: $0 key [action]"
#             return 2 # usage errors return 2 by default
#             ;;
#     esac
# }

# TAB and cursor keys:
#
# keybind $'\E[D' $'\002'
# keybind $'\E[C' $'\006'
# keybind $'\E[B' $'\016'
# keybind $'\E[A' $'\020'
# keybind $'\t' $'\E\E'

# another way to do the same thing, from https://github.com/larsklemstein/dotfiles/blob/master/dot.kshrc

# Use keyboard trap to map keys to other keys
# note that escape sequences vary for different terminals so these
# may not work for you
# trap '.sh.edchar=${keymap[${.sh.edchar}]:-${.sh.edchar}}' KEYBD
# keymap=(
#   [$'\eOD']=$'\eb'   # Ctrl-Left  -> move word left
#   [$'\eOC']=$'\ef'   # Ctrl-Right -> move word right
#   [$'\e[3~']=$'\cd'  # Delete     -> delete to right
#   [$'\e[1~']=$'\ca'  # Home       -> move to beginning of line
#   [$'\e[4~']=$'\ce'  # End        -> move to end of line
# )

# ksh88 setting of line-editing characters...
# apparently ksh93 does it too, the below is from the ksh93 man page
# but I couldn’t get it to work.

# from ksh93-20120801 man page...
# M-letter  Soft-key  - Your alias list is searched for an alias by the name _letter and if an alias of
#           this name is defined, its value will be inserted on the input queue.  The letter  must  not
#           be one of the above meta-functions.
# M-[letter Soft-key - Your alias list is searched for an alias by the name __letter and if an alias of
#           this name is defined, its value will be inserted on the input queue.  This can be  used  to
#           program function keys on many terminals.

# alias __A=`echo "\020"`     # up arrow = ^p = back a command
# alias __B=`echo "\016"`     # down arrow = ^n = down a command
# alias __C=`echo "\006"`     # right arrow = ^f = forward a character
# alias __D=`echo "\002"`     # left arrow = ^b = back a character
# alias __H=`echo "\001"`     # home = ^a = start of line
# alias __Y=`echo "\005"`     # end = ^e = end of line
