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
