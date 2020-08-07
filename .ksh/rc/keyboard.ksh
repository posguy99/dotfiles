#!/usr/bin/env ksh

# set up home/end/pgup/pgdn/fwddel
# apparently everyone else uses the keybind thing from the bolsky book
# but you can't see what that does in the environment

keybd_trap () {
  case ${.sh.edchar} in
    $'\e[1~') .sh.edchar=$'\001';;      # Home = beginning-of-line
    $'\e[4~') .sh.edchar=$'\005';;      # End = end-of-line
    $'\e[5~') .sh.edchar=$'\e>';;       # PgUp = history-previous
    $'\e[6~') .sh.edchar=$'\e<';;       # PgDn = history-next
    $'\e[3~') .sh.edchar=$'\004';;      # Delete = delete-char
    $'\030')  .sh.edchar=$'\001\013';;  # ctrl-x = delete line according to New Kornshell book, Mac uses ^U
  esac
}
trap keybd_trap KEYBD

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
