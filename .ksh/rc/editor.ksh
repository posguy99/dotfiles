#!/usr/bin/env ksh

# find an editor to use.  Note: using textmate will break crontab -e

if [[ -e /usr/local/bin/mate ]]; then
    export EDITOR='/usr/local/bin/mate -w'          # textmate is preferred
elif [[ -e /usr/local/bin/bbedit ]] ; then
    export EDITOR='/usr/local/bin/bbedit -w'        # BBEdit otherwise
elif [[ -e $(which mg) ]]; then
    export EDITOR=$(which mg)                       # microemacs is acceptable
else
    export EDITOR=$(which vi)                       # vi should always be there
fi

export VISUAL=${EDITOR}

# set FCEDIT to an editor that runs in a terminal

if [[ -e $(which mg) ]]; then
    export FCEDIT=$(which mg)                       # microemacs
else
    export FCEDIT=$(which vi)                       # vi should always be there
fi

export HISTEDIT=${FCEDIT}
