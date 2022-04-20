#!/bin/sh

# xat: execute at is used to execute a command into a specific directory
#   then coming back to the initial directory
export xat = function () {
    location=$1
    command=(${@:2})

    cd $location > /dev/null
    "${command[@]}"
    cd - > /dev/null
}
