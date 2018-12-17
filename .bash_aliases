#!/usr/bin/env bash

# This script is for aliases.
# It has conditions for both macOS and Linux (Ubuntu)

# Different directory colors for quick use with ls/gls
LS_COLORS=$LS_COLORS:'di=1;04;32:'; export LS_COLORS # green
# LS_COLORS=$LS_COLORS:'di=01;04;93:'; export LS_COLORS # bold;underlined;yellow
# LS_COLORS=$LS_COLORS:'di=1;47:' ; export LS_COLORS # white on light grey
# LS_COLORS=$LS_COLORS:'di=1;46:' ; export LS_COLORS # white on biruza
# LS_COLORS=$LS_COLORS:'di=1;45:' ; export LS_COLORS # white on pink
# LS_COLORS=$LS_COLORS:'di=1;44:' ; export LS_COLORS # white on blue
# LS_COLORS=$LS_COLORS:'di=1;43:' ; export LS_COLORS # white on gold
# LS_COLORS=$LS_COLORS:'di=1;42:' ; export LS_COLORS # white on green
# LS_COLORS=$LS_COLORS:'di=1;41:' ; export LS_COLORS # white on red
# LS_COLORS=$LS_COLORS:'di=01;40:' ; export LS_COLORS # white on black
# LS_COLORS=$LS_COLORS:'di=1;04;35:' ; export LS_COLORS # ubuntu purple
# LS_COLORS=$LS_COLORS:'di=1;36:' ; export LS_COLORS # cyan
# LS_COLORS=$LS_COLORS:'di=1;33:' ; export LS_COLORS # yellow
# LS_COLORS=$LS_COLORS:'di=1;31:' ; export LS_COLORS # red
# LS_COLORS=$LS_COLORS:'di=1;30:' ; export LS_COLORS # black
# LS_COLORS=$LS_COLORS:'di=1;1:' ; export LS_COLORS # white
# LS_COLORS=$LS_COLORS:'di=1;5:' ; export LS_COLORS # blinking white
# LS_COLORS=$LS_COLORS:'di=1;04;4:' ; export LS_COLORS # underlined white
# LS_COLORS=$LS_COLORS:'di=1;04;7:' ; export LS_COLORS # background white


# enable color support of ls and also add handy aliases
if [[ $OSTYPE =~ "darwin" ]] ; then
    # This will work for macOS

    # Latest vim (brew install vim)
    alias vim='OSTYPE=darwin /usr/local/bin/vim/'

    # GNU coreutils (brew install coreutils)
    # `g` prefix is the GNU equivalent, e.g. `gls -la == ls -la`
    alias l='gls --color=auto'
    alias ll='LC_COLLATE="C" LC_ALL="C" gls -FlhA --color=auto --group-directories-first'

    alias dir='gdir --color=auto'
    alias vdir='gvdir --color=auto'
else
    # Assuming Ubuntu Linux
    alias ls='ls --color=auto'
    alias l='ls'
    alias ll='LC_COLLATE="C" LC_ALL="C" ls -FlhA --color=auto --group-directories-first'

    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
fi

# Grep colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git
# alias git=hub

# Misc
alias rmDCStore="find . -name '*.DS_Store' -type f -delete"
