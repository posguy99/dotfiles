# .kshrc
# msw@cox.net

# skip this setup for non-interactive shells
[[ -o interactive && -t 0 ]] || return

# Source global definitions

if [ -f /etc/ksh.kshrc ]; then
        . /etc/ksh.kshrc
fi

# path

#PATH=$PATH:$HOME/bin
#PATH=/opt/local/bin:/opt/local/sbin:$PATH

FOLDER=$HOME/.ksh                   # base folder for configuration and history

mkdir -p $FOLDER/fun                # location of autoload functions
FPATH=$FOLDER/fun

mkdir -p $FOLDER/rc                 # location of user rc files
RCPATH=$FOLDER/rc

mkdir -p $HOME/.vim/backups	        # so vimrc doesn't error out
mkdir -p $HOME/.vim/colors

mkdir -p $HOME/.mg.d                # backup folder for mg(1)
mkdir -p $HOME/.nano                # backup folder for nano(1)

HOSTNAME=$(hostname -s)             # hostname

mkdir -p $FOLDER/histfiles          # location of history files

TTY=$(bn $(tty))
HISTFILE=$FOLDER/histfiles/history.${TTY}
HISTSIZE=500

# user setup

if [[ -e $RCPATH/vars ]] ; then
    . $RCPATH/vars
fi

if [[ -e $RCPATH ]] ; then
    for ksh in $RCPATH/*.ksh ; do
        [[ -e $ksh ]] || continue
        . "$ksh"
    done
    unset -v ksh
fi

# options

set -o emacs                        # edit mode
set +o histexpand                   # csh-style history off (I like it, but got bit twice now, so it goes)
set -o multiline                    # turn on multiline mode ref: https://github.com/ksh93/ksh/issues/71
set -o ignoreeof                    # don't exit on ctrl-d
set -o notify                       # immediate notification from background jobs
# nolog option removed @0f7f46d7
# set -o nolog                        # don't save function defs in history (have to think about this)

# trackall option removed @0f7f46d7
# set -o trackall                     # does this really increase performance on modern systems?

if [ ${SHLVL} -lt 2 ] ; then
    # fortune can be fun, but eventually the extra noise will make me remove it
    # but don't do it on subshells, what's the point?
    [[ -n "$(whence fortune)" ]] && printf "\n%s\n\n" "$(fortune -s)"

    ver                             # display version string
fi

# done
