#!/usr/bin/env ksh

# aliases

if [[ -e $HOME/.bcrc ]]; then
    alias bc='bc -q $HOME/.bcrc'
else
    alias bc='bc -q'
fi

if [[ -e $(which rmate) ]] ; then                    # is rmate on the path?
    alias rmate='rmate --host auto'
else
    alias rmate='printf "You will need to install rmate from https://github.com/sclukey/rmate-python\n"'
fi

alias cdb='cd $OLDPWD'
alias cls='tput clear'

alias grep='grep --color=auto'

alias ls='ls -GF'
alias ll='ls -lG'
alias la='ls -AG'
alias l='ls -CFG'

alias m='most -t4'

alias md=mkdir

alias rebuildLS='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain system -domain user'

# this is bad, should NOT do this...
# leads to BAD habits

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'

# from jaybe on #macosx
alias tree='find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g''

# # Add the remote, call it "upstream":
#
# git remote add upstream https://github.com/whoever/whatever.git
#
# # Fetch all the branches of that remote into remote-tracking branches,
# # such as upstream/master:
#
# git fetch upstream
#
# # Make sure that you're on your master branch:
#
# git checkout master
#
# # Rewrite your master branch so that any commits of yours that
# # aren't already in upstream/master are replayed on top of that
# # other branch:
#
# git rebase upstream/master

alias update_github='git fetch upstream && git checkout master && git rebase upstream/master && git push origin master'

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
