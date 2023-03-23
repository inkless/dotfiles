alias vi=nvim
alias vim=nvim
alias vimdiff="nvim -d"

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

alias emc="emacsclient -nc"
alias em="emacsclient -n"
alias dosbox="$HOME/dosbox-x/dosbox-x/dosbox-x.app/Contents/MacOS/dosbox-x > /dev/null 2>&1 &"
