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

# this does not deal with spaces in paths right now.

if [ "${KSH_VERSION-no}" != "no" ]; then

    typeset i new_path path_file=$HOME/.paths
    typeset -a path_array

    if [ -e ${path_file} ]; then

        #read the file into the array
        path_array=($(cat $path_file))

        # debug
        # printf "%s\n" ${path_array[*]}

        for i in ${path_array[*]}
        do
            [[ -d $i ]] && new_path=${i}:${new_path}
        done

        PATH=${new_path}${PATH}
    fi

    unset i new_path path_file path_array
fi

export PATH
