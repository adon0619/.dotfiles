#-----------------------------------------
# Prompt
#-----------------------------------------
autoload colors
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '[%b]'
zstyle ':vcs_info:*' actionformats '[%b|%a]'

precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}

colors
PROMPT="%n@%m%# "
RPROMPT="%B%{${fg[red]}%}[%~]%{${reset_color}%}%1(v|%F{green}%1v%f|)%b"

#-----------------------------------------
# History
#-----------------------------------------
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups
setopt share_history

#-----------------------------------------
# Completion
#-----------------------------------------
autoload -U compinit
#-----------------------------------------
#setopt complete_aliases
#-----------------------------------------
compinit
setopt auto_list
setopt list_packed
setopt auto_menu

#-----------------------------------------
# Share Config
#-----------------------------------------
source_file=~/.source;
if [ -e $source_file ]; then
    source $source_file;
fi
unset source_file;
