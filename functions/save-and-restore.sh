# Allow to save part of an env or the full env

SAVE_DIRECTORY=~/.save-and-restore

function save() {
    name=$1
    mkdir $SAVE_DIRECTORY &> /dev/null

    if [[ -z $name ]]; then
      name="default"
    fi

    export > $SAVE_DIRECTORY/$name

    echo "Export environment variables into $name."
}

function restore() {
    name=$1
    mkdir $SAVE_DIRECTORY &> /dev/null

    if [[ -z $name ]]; then
      name="default"
    fi

    echo "Import environment variables from $name."

    target=$SAVE_DIRECTORY/$name
    source $target
    [ -f "$target" ] && source $target
}

function _save-and-restore() {
  _arguments "1:path:_path_files -W '$SAVE_DIRECTORY'"
}

compdef _save-and-restore save restore