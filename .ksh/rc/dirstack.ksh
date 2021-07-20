# Implement a csh-like directory stack in ksh
#
# environment variable dir_stack contains all directory entries except
# the current directory

# taken from https://stackoverflow.com/questions/984635/pushd-popd-on-ksh
# specifically https://stackoverflow.com/a/57021646/13100156

# msw
# added a few quotations so that it could deal with spaces in names.

unset _dir_stack
export _dir_stack


# Three forms of the pushd command:
#    pushd        - swap the top two stack entries
#    pushd +3     - swap top stack entry and entry 3 from top
#    pushd newdir - cd to newdir, creating new stack entry

function pushd
{
   typeset -i _sd _ids _dsdel
   _sd=${#_dir_stack[*]}  # get total stack depth
   if [ "$1" ] ; then
      if [ "${1#\+[0-9]*}" ] ; then
         # ======= "pushd dir" =======

         # is "dir" reachable?
         if [ `(cd "$1") >/dev/null 2>&1; echo $?` -ne 0 ] ; then
            cd "$1"             # get the actual shell error message
            return 1            # return complaint status
         fi

         # yes, we can reach the new directory; continue

         (( _sd = _sd + 1 ))      # stack gets one deeper
         _dir_stack[_sd]=$PWD
         cd "$1"
         # check for duplicate stack entries
         # current "top of stack" = ids; compare ids+dsdel to $PWD
         # either "ids" or "dsdel" must increment with each loop
         #
         (( _ids = 1 ))          # loop from bottom of stack up
         (( _dsdel = 0 ))        # no deleted entries yet
         while [ _ids+_dsdel -le _sd ] ; do
            if [ "${_dir_stack[_ids+_dsdel]}" = "$PWD" ] ; then
               (( _dsdel = _dsdel + 1 ))  # logically remove duplicate
            else
               if [ _dsdel -gt 0 ] ; then        # copy down
                  _dir_stack[_ids]="${_dir_stack[_ids+_dsdel]}"
               fi
               (( _ids = _ids + 1 ))
            fi
         done

         # delete any junk left at stack top (after deleting dups)

         while [ _ids -le _sd ] ; do
            unset _dir_stack[_ids]
            (( _ids = _ids + 1 ))
         done
         unset _ids
         unset _dsdel
      else
         # ======= "pushd +n" =======
         (( _sd = _sd + 1 - "${1#\+}" ))    # Go 'n - 1' down from the stack top
         if [ _sd -lt 1 ] ; then (( _sd = 1 )) ; fi
         cd ${_dir_stack[_sd]}            # Swap stack top with +n position
         _dir_stack[_sd]=$OLDPWD
      fi
   else
      #    ======= "pushd" =======
      # swap only if there's a value to swap with
      if [ ${#_dir_stack[*]} = "0" ]; then
         echo "ksh: pushd: no other directory" >&2
      else
         cd ${_dir_stack[_sd]}       # Swap stack top with +1 position
         _dir_stack[_sd]=$OLDPWD
      fi
   fi
}

function popd
{
   typeset -i _sd
   _sd=${#_dir_stack[*]}
   if [ $_sd -gt 0 ] ; then
      cd "${_dir_stack[_sd]}"
      unset _dir_stack[_sd]
   else
      cd ~
   fi
}

function dirs
{
   typeset -i _sd _ind
   echo "0: $PWD"
   _sd=${#_dir_stack[*]}
   (( _ind = 1 ))
   while [ $_sd -gt 0 ]
   do
      echo "$_ind: ${_dir_stack[_sd]}"
      (( _sd = _sd - 1 ))
      (( _ind = _ind + 1 ))
   done
}
