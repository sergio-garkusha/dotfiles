# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Path to the bash it configuration (OS depenent)
if [ "$OSTYPE" == 'darwin18' ]; then
    export BASH_IT="/Users/$USER/.bash_it"
else
    export BASH_IT="/home/$USER/.bash_it"
fi

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='cu7ious'

# Don't check mail when opening terminal.
# unset MAILCHECK

# Change this to your console based IRC client of choice.
# export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
# export TODO="t"

# Set this to false to turn off version control status checking
# within the prompt for all themes
# export SCM_CHECK=true

# bind 'set show-all-if-ambiguous on'
bind 'TAB:menu-complete'
bind 'set completion-ignore-case on'

# Load Bash It
# shellcheck source=/dev/null
source "$BASH_IT"/bash_it.sh

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
if [ -f ~/.bash_aliases ]; then
    # shellcheck source=/dev/null
    . ~/.bash_aliases
fi
