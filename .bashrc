#-----------------------------------------
# Prompt
#-----------------------------------------
PS1="\u@\h:\w\$ "

#-----------------------------------------
# Share Config
#-----------------------------------------
source_file=~/.source;
if [ -e $source_file ]; then
    source $source_file;
fi
unset source_file;

#-----------------------------------------
# bash_profile
#-----------------------------------------
bash_profile_file=~/.bash_profile;
if [ -e $bash_profile_file ]; then
    source $bash_profile_file;
fi
unset bash_profile_file
