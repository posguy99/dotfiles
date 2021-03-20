#!/usr/bin/env ksh

# took out the GUI editors, they're nice, but now that I'm doing so much SSH
# it bites hard when it tries to launch one as $EDITOR or $VISUAL

# find an editor to use.  Note: using textmate will break crontab -e

# if [[ -e /usr/local/bin/mate ]]; then
#     export EDITOR='/usr/local/bin/mate -w'              # textmate is preferred
# elif [[ -e /usr/local/bin/bbedit ]] ; then
#     export EDITOR='/usr/local/bin/bbedit -w'            # BBEdit otherwise
# elif whence -pq mg; then

if whence -pq mg; then
    export EDITOR=$(whence -p mg)                       # microemacs is acceptable
else
    export EDITOR=$(whence -p vi)                       # vi should always be there
fi

export VISUAL=${EDITOR}

# set FCEDIT to an editor that runs in a terminal

if whence -pq mg; then
    export FCEDIT=$(whence -p mg)                       # microemacs
else
    export FCEDIT=$(whence -p vi)                       # vi should always be there
fi

export HISTEDIT=${FCEDIT}
