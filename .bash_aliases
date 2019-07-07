alias vi=nvim
alias vim=nvim
alias pwserver='foreman start -m all=1,unicorn=0 -d . -f procfiles/local-server.procfile'
alias pwunicorn='foreman start unicorn -d . -f procfiles/local-server.procfile'
alias pwdebug='env WEB_TIMEOUT_UNICORN=300000 WEB_TIMEOUT_SECONDS=300000 WEB_CONCURRENCY=1 PORT=3002 SQUEW_POOL=false bin/launcher-dev.sh unicorn -c config/unicorn.rb'
alias nexus5x='$HOME/Library/Android/sdk/tools/emulator @Nexus_5X_API_27'
alias pwsql='psql crm_dev --port 9750'
alias cleos='docker exec eosio /opt/eosio/bin/cleos --wallet-url http://localhost:8888'

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
