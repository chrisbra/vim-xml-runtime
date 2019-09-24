#!/bin/sh

#set -x

# Setup some color variables
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)
rc=0

# needs to be run in the same subprocess, otherwise setting rc won't work
for i in */; do
  {
    cd "$i" &&
    test -f "cmd" &&
    ./cmd
    if [ -f output.dump ]; then
      diff -qu output.dump  reference.dump >/dev/null
      diff_rc=$?
    fi
    if [ -f SKIPPED ]; then
      printf "Test %s:\t\t[${yellow}Skipped${reset}]\n" ${i%%/}
    elif [ $diff_rc -ne 0 ]; then
      printf "Test %s:\t\t[${red}Failed${reset}]\n" ${i%%/}
      rc=1
    else
      printf "Test %s:\t\t[${green}OK${reset}]\n" ${i%%/}
    fi
    cd "$OLDPWD"
    }
done
exit $rc
