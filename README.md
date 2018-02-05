### For vim

1. Set up [Vundle](https://github.com/VundleVim/Vundle.vim)

```git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim```

2. Move .vimrc from this dir to the home dir and create `tmp` & `undo` inside ~/.vim

```mv .vimrc ~/ && mkdir -p ~/.vim/tmp && mkdir -p ~/.vim/undo```

3. Open vim and type in:

```:PluginInstall```

4. Inside `.vim` directory make symbolic link to `~/.vim/bundle/vim-colorschemes/colors/`

```ln -s ~/.vim/colors/ .```

After this step it should work.


### For zsh
1. install zsh with oh-my-zsh

```sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"```

2. Make it your default shell: `chsh -s $(which zsh)`

Note that this will not work if Zsh is not in your authorized shells list `(/etc/shells)` or if you don't have permission to use `chsh`.

3. Log out and login back again to use your new default shell.
4. Test that it worked with echo $SHELL. Expected result: /bin/zsh or similar.
5. Copy or make the symlink for `cu7ious.zsh-theme` to ~/.oh-my-zsh/themes

### For bash

1. install bash-it
```git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it```
2. Add this lines to the end of the `.bashrc`

```
# Path to the bash it configuration
export BASH_IT="/home/vagrant/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='cu7ious'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Load Bash It
source "$BASH_IT"/bash_it.sh
```

5. Copy or make the symlink for `cu7ious.` to ~/.oh-my-zsh/themes
