#!/bin/bash

DEFAULT_MAX=5

max=$DEFAULT_MAX
verbose=no
pos_args=()

# Parse arguments

while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Usage: `basename "$0"` [options] <path to target> <path to backup folder>"
            echo
            echo "Options:"
            echo "  -h, --help    - Show help"
            echo "  -v, --verbose - Enable verbose mode"
            echo "  -m            - Specify maximum number of backup entries"
            echo "                  Default value is $DEFAULT_MAX"
            echo
            echo "About:"
            echo "  This  bash  script  manages  backups. It creates a backup of target"
            echo "  file passed to it as the first argument in the backup folder passed"
            echo "  to it as the secod argument. If backup folder doesn't exist it will"
            echo "  be created. Backups are stored as .tag.gz archives with name set to"
            echo "  it's  creation  date.  By  default  this script will create up to 5"
            echo "  backups  removing  old  ones  on  attempt to create a new one. This"
            echo "  behaviour  can  be  overridden by passing an -m (or --max) argument"
            echo "  set to desired amount."

            exit

            ;;

        -v|--verbose)
            verbose=yes
            shift
            ;;

        -m)
            shift

            if ! [[ $1 =~ ^[0-9]+$ ]]; then
                echo "$1 is not a number" 
                exit 1
            fi

            max=$1

            shift

            ;;

        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;

        *)
            pos_args+=("$1")
            shift
            ;;
    esac
done

# Check number of positional arguments

if [[ ${#pos_args[*]} -ne 2 ]]; then
    echo "Invalid number of arguments"
    echo "Use -h or --help option to see help"
    exit 1
fi

target=${pos_args[0]}
backup=${pos_args[1]}

# Check if target file exists

if ! [[ -a "$target" ]]; then
    echo "Target file $target doesn't exits"
    exit 1
fi

mkdir -p "$backup"

count=$(ls "$backup" | wc -l)
diff=$(($count + 1 - $max))

# Remove too old backups

if [[ $diff -gt 0 ]]; then
    if [[ $verbose == yes ]]; then
        echo "Maximum number of backups reached"
        echo "Removing $diff oldest backup(s):"
    fi

    to_delete=$(ls -t $"backup" | tail -$diff)

    for file in $to_delete; do
        file="$backup/$file"

        echo -n "Removing $file... "
        rm -rf "$file"
        echo "Done"
    done
fi

# Create backup

backup="$backup/$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

if [[ $verbose == yes ]]; then
    echo
    echo "Creating backup $backup..."
    flags=-cavf
else
    flags=-caf
fi

tar $flags "$backup" "$target"

if [[ $verbose == yes ]]; then
    echo "Backup creation is finished"
fi
