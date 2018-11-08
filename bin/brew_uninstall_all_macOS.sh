#!/usr/bin/env bash

FILENAME=brew-formulas-currently-installed.txt

brew list | tr -s '\t' > $FILENAME

while read -r line; do
    brew uninstall --ignore-dependencies "$line"
done < $FILENAME

rm $FILENAME
