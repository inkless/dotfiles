alias vi=nvim
alias vim=nvim
alias nexus5x='$HOME/Library/Android/sdk/tools/emulator @Nexus_5X_API_27'

# ncdu
alias du="ncdu --color dark -rr -x --exclude .git --exclude node_modules"

# Pipe Highlight to less
export LESSOPEN="| $(which highlight) %s --out-format xterm256 --quiet --force --style solarized-light"
export LESS=" -R"
alias less='less -m -g -i -J --underline-special'
alias more='LESSOPEN= LESS= \less'

# Use "highlight" in place of "cat"
# alias cat="highlight $1 --out-format xterm256 --quiet --force --style solarized-light"

alias google-chrome='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome'
alias shome='ssh inkless@`curl -u inkless:homeip@123 https://www.zhangguangda.com/home_ip/thinkpad-p50` -p 58422'

# e.g.
# activate_venv meta
# activate_venv data-platform
activate_venv() {
  local target=$1
  local venv='.venv3'
  if [ "$target" = 'monolith' ]; then
    venv='.venv'
  fi

  # shellcheck source=workspace/all-the-things/deployable/monolith/src/.venv/bin/activate
  source "$HOME/workspace/all-the-things/deployable/$target/src/$venv/bin/activate"
}
