# Change iterm2 profile. Usage it2prof ProfileName (case sensitive)
it2prof() {
  echo -e "\033]50;SetProfile=$1\a"
}
