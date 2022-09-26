#!/usr/bin/env ksh

# aliases per OS in use

_aliases="$FOLDER/rc/aliases.$OSTYPE"

[[ -e $_aliases ]] && . "$_aliases"
unset -v _aliases

# aliases for both OS

# deal with stupid nano differences in a terrible way
if [[ -e $HOME/.nanorc-${HOSTNAME} ]]; then
    alias nano="nano --rcfile ~/.nanorc-${HOSTNAME}"
elif [[ -e $HOME/.nanorc-${OSTYPE} ]]; then
    alias nano="nano --rcfile ~/.nanorc-${OSTYPE}"
fi

[[ -e $FPATH/man ]] && autoload man

[[ -e $HOME/.bcrc ]] && alias bc='bc -q $HOME/.bcrc' || alias bc='bc -q'

# [[ -n "$(whence emacs)" ]] && alias emacs='emacs -nw' || alias emacs='mg'
if [[ -e /Applications/Emacs.app/Contents/MacOS/Emacs ]]; then
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs -nw'
    alias gmacs='/Applications/Emacs.app/Contents/MacOS/Emacs '
elif [[ -n "$(whence emacs)" ]]; then
    alias emacs='emacs -nw'
elif [[ -n "$(whence qemacs)" ]]; then
    alias emacs='qemacs'
else
    # macOS ships mg, so it is most likely always there
    alias emacs='mg'
fi

# what was that DOS editor from back in the day
# that you invoked with just 'q'...
[[ -n "$(whence qemacs)" ]] && alias q='qemacs'

[[ -n "$(whence python3)" ]] &&  alias venv='python3 -m venv'
[[ -n "$(whence most)" ]] && alias m=most

alias cdb='cd $OLDPWD'
alias cls='tput clear'

alias df='df -h'
alias du='du -ch'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# stupid dos tricks...
alias md='mkdir'
alias rd='rmdir'
alias cd..='cd ..'
alias cd...='cd ../..'

alias edit=\${EDITOR}

# this is bad, should NOT do this...
# leads to BAD habits

alias mv='mv -i'
alias rm='rm -i'
alias cp='cp -i'
alias ln='ln -i'

# psgrep using options common to both macOS and Linux
alias psgrep="ps aux | grep -v grep | grep $1"

# from jaybe on #macosx
[[ -z "$(whence tree)" ]] && alias tree=$'find . -print | sed -e \'s;[^/]*/;|____;g;s;____|; |;g\''

# manage dotfiles
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# human readable path
alias path='printf -- "${PATH//:/\\n}\n"'

# external IP address
alias wanip='printf -- "External IP: $(curl -s --get http://tnx.nl/ip)\n"'

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
