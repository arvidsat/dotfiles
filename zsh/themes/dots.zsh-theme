PROMPT='
 '
PROMPT+='%1(j:%{$fg[green]%}:%{$fg[cyan]%})●' 
PROMPT+='%(?:%{$fg[cyan]%}:%{$fg[red]%})●'
PROMPT+='%{$fg[cyan]%}$(git_prompt_status)●'
PROMPT+=' %{$fg[green]%}%~'
PROMPT+='
 '
PROMPT+='%(!:%{$fg[red]%}!:%{$fg[cyan]%}-) '
PROMPT+='%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_DIVERGED="%{$fg[magenta]%}"
