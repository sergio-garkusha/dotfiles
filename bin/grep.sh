#!/usr/bin/env bash
grep --color -rn . -e "$1" --exclude-dir .git --exclude-dir node_modules
