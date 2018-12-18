#!/usr/bin/env bash

# Finds files by name in a current directory.
# If specified, excludes subpathes

count=1
dirs_to_skip="-type d ("

for arg in "$@" ; do
    if [ $count == 1 ] ; then
        ((count++))
        continue
    fi

    if [ $count == 2 ] ; then
        dirs_to_skip="$dirs_to_skip -path ./$arg"
    else
        dirs_to_skip="$dirs_to_skip -o -path ./$arg"
    fi

    ((count++))
done

dirs_to_skip="$dirs_to_skip ) -prune -o "

# shellcheck disable=SC2086
find . ${dirs_to_skip} -name "$1" -print
