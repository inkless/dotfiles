#!/bin/bash
BRANCHES=(
  dev
  gz/migrate-embedded-app
  gz/native-embedded-app
  gz/marketplace-team-permission
)

GREP="\[ALI-"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

for i in "${!BRANCHES[@]}"; do
  if [ "$i" -eq "0" ]; then
    continue;
  fi

  prev=$((i-1))
  new_branch="${BRANCHES[$i]}"
  base_branch="${BRANCHES[$prev]}"

  git checkout $new_branch

  echo "--------------------"
  echo "Looking for the most likely commit to rebase..."

  first_commit=`git log -1 --pretty=format:"%h" --grep $GREP`
  base_commit=`git log -2 --pretty=format:"%h" ${first_commit} | tail -1`
  echo -e "Most likely commit: ${GREEN}${base_commit}${NC}"
  git lg -2 $first_commit

  while true; do
    read -p "Do you wish to rebase this commit to ${base_branch}? (Y/N) " yn
    case $yn in
      [Yy]* )
        echo -e "${YELLOW}rebasing ${new_branch} to ${base_branch} from ${base_commit}...${NC}"
        git rebase ${base_commit} --onto ${base_branch}
        git push --force
        break;;
      [Nn]* ) exit;;
      * ) echo "Please answer yes or no.";;
    esac
  done
done
