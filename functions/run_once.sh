#!/bin/sh

# Run a script based on git diff between two execution
export run_once = function () {

    # Parameters
    command=(${@:1})

    # Internal vars
    lock_dir=/tmp/once
    lock_file=$lock_dir/`echo "$command" | md5sum | awk '{ print $1 }'`

    # Apply the command and save md5 if there is diffs
    if [ ! -f $lock_file ] ; then
        mkdir -p $lock_dir &> /dev/null
        touch $lock_file &> /dev/null        
        "${command[@]}"
    fi
}
