# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

PATH=$PATH:$HOME/bin

export PATH

##
# Your previous /Users/mwilson/.bash_profile file was backed up as /Users/mwilson/.bash_profile.macports-saved_2011-08-29_at_18:13:11
##

# MacPorts Installer addition on 2011-08-29_at_18:13:11: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


# Created by `userpath` on 2021-02-06 17:26:28
export PATH="$PATH:/Users/mwilson/.local/bin"

# Created by `userpath` on 2021-02-06 17:26:29
export PATH="$PATH:/Users/mwilson/Library/Python/3.9/bin"
