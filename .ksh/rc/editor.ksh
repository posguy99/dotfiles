#!/usr/bin/env ksh

# list of editors that might be installed on the system
# in reverse order of desirability for me to use
# the last one it finds is obv the one that will be used

editors="nano vi vim mg"

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
