#!/usr/bin/env ksh

# set the pager to use

if [[ -e $(which most) ]] ; then                    # is most(1) pager on the path?
    export PAGER=$(which most)                      # set it as the pager
elif [[ -e $(which less) ]] ; then
    # LESS
    # g    == highlight only the particular string which was found by the last search
    # i.   == case-insensitive search
    # R    == ANSI "color" escape sequences are output in "raw" form
    # j.25 == where the "target" line is to be positioned
    # P    == %t          - strip all trailing spaces
    #      == ?f%f:stdin. - if the input is a file, include the file name, else 'stdin'
    #      == ?pb%pb\%    - if the percentage into the file of bottom line in bytes is known, include pct
    #      == :           - otherwise
    #      == ?lbLine %lb - if the line offset into the file of bottom line is known, include line offset
    #      == :           - otherwise
    #      == ?bbByte %bb - if the byte offset into the file of bottom line is known, include byte offset
    #      == ...         - endif ; endig ; endif    ^_^
    #      ==             - the rest is just help text to display
    export LESS='-giR -j.25 -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-... -- \spc\:page fwd b\:page bck /\:search fwd \?\:search bck h\:help q\:quit'
    #export LESS='-giMR -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
    #export LESS='-giR -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'
    export LESSOPEN="|/Users/mwilson/bin/lesspipe.sh %s"
    export PAGER=$(which less)
else
    export PAGER=$(which more)
fi
