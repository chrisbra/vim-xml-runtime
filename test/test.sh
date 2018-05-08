#!/bin/sh

#set -x

# Setup some color variables
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)

for i in */; do
  (
    cd "$i" &&
    test -f "cmd" &&
    ./cmd
    diff -qu output.xml  reference.xml >/dev/null
    if [ $? -ne 0 ]; then
      printf "Test %s:\t\t[${red}Failed${reset}]\n" ${i%%/}
      if [ -n "$1" ] && [ "${1}" -eq "-v" ]; then
        diff -u output.xml reference.xml
      fi
    else
      printf "Test %s:\t\t[${green}OK${reset}]\n" ${i%%/}
    fi
    )
done
