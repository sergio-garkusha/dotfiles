# Zsh prompt colorizer by CU7IOUS
# Recommended to use with some dark background and with fonts like
# Ubuntu Mono, Fira Mono, Hack,  Inconsolata etc.
# Colours: black, red, green, yellow, blue, magenta, cyan, and white.

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# VCS
C7_VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
C7_VCS_PROMPT_SUFFIX="%{$reset_color%}"
C7_VCS_PROMPT_DIRTY=" %{$fg[red]%}✖︎ "
C7_VCS_PROMPT_CLEAN=" %{$fg[green]%}● "

# Git info.
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="git${C7_VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$C7_VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$C7_VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$C7_VCS_PROMPT_CLEAN"

# HG info
local hg_info='$(c7_hg_prompt_info)'
c7_hg_prompt_info() {
	# make sure this is a hg dir
	if [ -d '.hg' ]; then
		echo -n "hg${C7_VCS_PROMPT_PREFIX2}"
		echo -n $(hg branch 2>/dev/null)
		if [ -n "$(hg status 2>/dev/null)" ]; then
			echo -n "$C7_VCS_PROMPT_DIRTY"
		else
			echo -n "$C7_VCS_PROMPT_CLEAN"
		fi
		echo -n "$C7_VCS_PROMPT_SUFFIX"
	fi
}

# Prompt format: $ USER in DIRECTORY
# git:BRANCH STATE →
PROMPT="
%{$fg[green]%}$%{$reset_color%} \
%{$fg[yellow]%}%n%{$reset_color%} \
%{$fg[white]%}in \
%{$fg[green]%}${current_dir}%{$reset_color%}
${hg_info}\
${git_info}\
%{$fg[red]%}→ %{$reset_color%}"

# Prompt format: # USER in DIRECTORY
# git:BRANCH STATE →
if [[ "$USER" == "root" ]]; then
PROMPT="
%{$fg[red]%}#%{$reset_color%} \
%{$fg[red]%}%n%{$reset_color%} \
%{$fg[white]%}in \
%{$fg[green]%}${current_dir}%{$reset_color%}
${hg_info}\
${git_info}\
%{$fg[red]%}→ %{$reset_color%}"
fi
