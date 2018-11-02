#!/usr/bin/env bash
# This script sets up a convenient environment
# Set of useful CLI programs and configs

if [ "$OSTYPE" == "darwin18" ];
  # If the os is macOS
  then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    BREW_SOFT=(bat coreutils git gnupg2 mc python shellcheck vim yarn)
    for package in "${BREW_SOFT[@]}"; do
      brew install "$package"
    done

  # If the os is not macOS (assuming Ubuntu)
  else
    exit 0
fi
