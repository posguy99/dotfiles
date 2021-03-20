#!/usr/bin/env ksh

# list of pagers that might be installed on the system
# in reverse order of desirability for me to use
# the last one it finds is obv the one that will be used

pagers="more pg w3m less most"

for index in $pagers; do
    if whence -pq $index; then
        PAGER=$(whence -p $index)
    fi
done

unset pagers index

export PAGER
