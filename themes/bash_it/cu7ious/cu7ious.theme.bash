#!/usr/bin/env bash

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" ${green}|"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

__clock() {
	if [[ ${THEME_CLOCK} == true ]]; then
		printf "$(clock_prompt) "
	fi
}

__bat_charge() {
	echo "$(~/bin/batcharge.py) "
}

[[ "$USER" == "root" ]] && userColor="${red}" || userColor="${yellow}"

function prompt_command() {
	PS1="\n$(__bat_charge)"
	PS1="${PS1}${userColor}Cu7ious${reset_color}"
	PS1="${PS1} in ${green}\w\n"
	PS1="${PS1}$(__clock)"
	PS1="${PS1}${bold_cyan}$(scm_prompt_char_info)"
	PS1="${PS1} ${red}→${reset_color} "
}

# Clock Prompt config
# THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$cyan"}
# THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$bold_cyan"}
# THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%H:%M"}
# THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%m-%d %H:%M"}

safe_append_prompt_command prompt_command
