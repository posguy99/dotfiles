# from https://www.cs.umd.edu/~srhuang/teaching/code_snippets/prompt_color.tcsh.html

# Add these lines to your ~/.cshrc.mine file on the linux grace machines...
# don't worry too much about what they mean.

# Colors!
set     red="%{\033[1;31m%}"
set   green="%{\033[0;32m%}"
set  yellow="%{\033[1;33m%}"
set    blue="%{\033[1;34m%}"
set magenta="%{\033[1;35m%}"
set    cyan="%{\033[1;36m%}"
set   white="%{\033[0;37m%}"
set     end="%{\033[0m%}" # This is needed at the end... :(

# Setting the actual prompt.  I made two separate versions for you to try, pick
# whichever one you like better, and change the colors as you want.  Just don't
# mess with the ${end} guy in either line...  Comment out or delete the prompt you don't use.

set prompt="${green}%n${blue}@%m ${white}%~ ${green}%# ${end}"
# set prompt="[${green}%n${blue}@%m ${white}%~ ]${end} "

# Clean up after ourselves...
unset red green yellow blue magenta cyan yellow white end
