#!/usr/bin/env bash
# This script sets up a convenient environment
# Set of useful CLI programs and configs

if [ "$OSTYPE" == "darwin18" ]; then
# If the os is macOS
    # Bash magic
        # installs bash-it framework
        git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it

        # check if .bash_profile is there
        if [ -f ~/.bash_profile ]; then
            if ! grep -Fq "source ~/.bashrc" ~/.bash_profile; then
                cat >> ~/.bash_profile <<- EOM
if [ -r ~/.bashrc ]; then
    # shellcheck source=/dev/null
    source ~/.bashrc
fi
EOM
            fi
        else
            cat > ~/.bash_profile <<- EOM
if [ -r ~/.bashrc ]; then
    # shellcheck source=/dev/null
    source ~/.bashrc
fi
EOM
        fi

        # Symlink .bashrc and .bash_aliases
        ln -s "$(pwd)/.bashrc" ~/
        ln -s "$(pwd)/.bash_aliases" ~/

        # link theme
        ln -s "$(pwd)/themes/cu7ious/" ~/.bash_it/themes

        # Test and apply it
        #shellcheck source=/dev/null
        source ~/.bash_profile

    # Homebrew magic
        # install homebrew
        /usr/bin/ruby -e "$(curl -fsSL \
            https://raw.githubusercontent.com/Homebrew/install/master/install)"

        # install required formulas
        while read -r formula; do
            brew install "$formula"
        done < brew/formulas.txt

    # Vim magic
        # create symlink to the .vimrc in user home folder
        ln -s "$(pwd)/.vimrc" ~/

        # install Vim plugin manager
        git clone https://github.com/VundleVim/Vundle.vim.git \
            ~/.vim/bundle/Vundle.vim

        # create folders for .swp files
        mkdir -p ~/.vim/tmp
        mkdir -p ~/.vim/undo

        # install vim plugins via Vundle
        vim +PluginInstall +qall

        # links colorschemes from bundle to vim root folder
        ln -s ~/.vim/bundle/vim-colorschemes/colors ~/.vim/
else
# If the os is not macOS (assuming Ubuntu)
    exit 0
fi
