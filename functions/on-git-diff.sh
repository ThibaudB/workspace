#!/bin/sh

# Run a script based on git diff between two execution
export on-git-diff = function () {

    # Parameters
    git_repository=$1
    git_relative_diff_path=$2
    command=(${@:3})

    # Internal vars
    watch_dir=~/.on-git-diff
    watch_file=$watch_dir/`echo "$1/$2" | md5sum | awk '{ print $1 }'`
    watch_file_finest=$watch_file-finest
    has_diff="1"

    # Check if diff since last use
    if [ -f $watch_file ]; then
        previous_run_commit_hash=$(< $watch_file)
        diff="$(git -C $git_repository diff $previous_run_commit_hash $git_relative_diff_path 2> /dev/null | cat)"
    else
        # First time, we run the script
        diff="$(git -C $git_repository diff $git_relative_diff_path 2> /dev/null | cat)"
        has_diff="0"
    fi

    # Create hash of current diffs
    diff_md5=`echo $diff | md5sum | awk '{ print $1 }'`

    # If diffs exists check that it doesn't match the previous diffs
    if [ ! -z "$diff" ] ; then
        if [ -f $watch_file_finest ]; then
            old_diff_md5=$(< $watch_file_finest)
            [ "$diff_md5" != "$old_diff_md5" ]
            has_diff="$?"
        else
            has_diff="0"
        fi
    fi

    # Apply the command and save md5 if there is diffs
    if [ $has_diff = "0" ] ; then
        mkdir -p $watch_dir &> /dev/null
        git -C $git_repository rev-parse HEAD > $watch_file
        echo $diff_md5 > $watch_file_finest
        "${command[@]}"
        return $?
    fi

    return 0
}

function _on-git-diff() {
    echo $@ >> /tmp/arg
    _arguments "1:path-directories:_path_files -/" "2:paths:_path_files -W '$1'" "*:string"
}

compdef '_on-git-diff arg1' on-git-diff