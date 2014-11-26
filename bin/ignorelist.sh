#!/usr/bin/env bash

set -eou pipefail

readonly USERNAME=$(echo "$1" | tr -d '@')

function user_exists_warning(){
  echo "$USERNAME is already on ignorelist. Exiting..."
  exit 1
}

function add_user_to_ignorelist(){
  echo "$USERNAME" >> ignorelist.txt
}

function add_ignorelist_to_git(){
  git add ignorelist.txt
  git commit -m "Add $USERNAME to ignorelist based on Arbitrary decision"
}

function main(){
  if [[ $(grep -i -e "$USERNAME" ignorelist.txt ) ]];then
    user_exists_warning
  else
    add_user_to_ignorelist
    add_ignorelist_to_git
  fi
}

main
