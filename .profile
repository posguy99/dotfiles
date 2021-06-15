#
# ~/.profile - msw
#

# bash has its whack reasons for reading and then not reading profile
# so subvert it because the only thing I really care about is that
#  a) it works with ksh
#  b) bash doesn't break something
#
# mksh defines KSH_VERSION as well and always reads ~/.profile if it's
# a login shell so this isn't perfect.

if [ "${KSH_VERSION-no}" != "no" ]; then

    PATH=$PATH:$HOME/bin
    PATH=/opt/local/bin:/opt/local/sbin:$PATH

    # Created by `userpath` on 2021-02-06 17:26:28
    PATH="$PATH:/Users/mwilson/.local/bin"

    # Created by `userpath` on 2021-02-11 02:58:07
    PATH="$PATH:/Users/mwilson/Library/Python/3.9/bin"

[[ -d /opt/mssql-tools ]] && PATH="$PATH:/opt/mssql-tools/bin"
fi

export PATH
