# Based on evan's prompt
# Shows the exit status of the last command if non-zero
# Uses "#" instead of "»" when running with elevated privileges
if [[ $UID -eq 0 ]]; then
    local user_host='%n'
    local user_symbol='%{${fg[red]}%}#'
else
    local user_host='%n'
    local user_symbol='%{${fg[blue]}%}»'
fi

local separator='%{${fg_bold[red]}%}::'
local current_dir='%{${fg[green]}%}%3~'
local exit_code='%(0?. . %{${fg[red]}%}%? )'
local git_branch='$(git_prompt_info)%{$reset_color%}'



#PROMPT="%m %{${fg_bold[red]}%}:: %{${fg[green]}%}%3~%(0?. . %{${fg[red]}%}%? )%{${fg[blue]}%}»%{${reset_color}%} "

PROMPT="${user_host} ${separator} ${current_dir}${exit_code}${user_symbol} ${git_branch}"


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"

