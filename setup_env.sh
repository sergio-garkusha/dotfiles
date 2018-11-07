#!/usr/bin/env bash
# This script sets up a convenient environment
# Set of useful CLI programs and configs

if [ "$OSTYPE" == "darwin18" ]; then
# If the os is macOS

    # install homebrew
    /usr/bin/ruby -e "$(curl -fsSL \
        https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # install required formulas
    while read -r formula; do
        brew install "$formula"
    done < brew/formulas.txt

else
# If the os is not macOS (assuming Ubuntu)
    exit 0
fi
