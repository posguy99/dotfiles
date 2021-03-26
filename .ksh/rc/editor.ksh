#!/usr/bin/env ksh

# list of editors that might be installed on the system
# in reverse order of desirability for me to use
# the last one it finds is the one that will be used

# putting a reminder here for myself that messing with
# $EDITOR and $VISUAL causes ksh to change the interactive
# editing mode.

# if you 'set -o <mode>' and then mess with $EDITOR, ksh
# will try to change the mode.

# if you set $EDITOR and $VISUAL first, then use 'set -o <mode>'
# ksh will leave it alone if you change $EDITOR later and will
# try to change the mode if you mess with $VISUAL.

# the usual effect is ksh changing to vi mode when one or the other
# of the variables contains a string starting with 'vi'

# yes, really

editors="vi vim nano jed mg"

for index in $editors; do
    if whence -pq $index; then
        EDITOR=$(whence -p $index)
    fi
done

VISUAL=${EDITOR}
FCEDIT=${EDITOR}
HISTEDIT=${FCEDIT}

unset editors index

export EDITOR VISUAL FCEDIT HISTEDIT
