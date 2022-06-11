###-begin-keevo-completions-###
#
# yargs command completion script
#
# Installation: keevo completion >> ~/.zshrc
#    or keevo completion >> ~/.zsh_profile on OSX.
#
_keevo_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" keevo --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _keevo_yargs_completions keevo
###-end-keevo-completions-###


