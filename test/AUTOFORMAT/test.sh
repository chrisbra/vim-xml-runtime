#!/bin/sh

#set -x

# Setup some color variables
red=$(tput setaf 1)
green=$(tput setaf 2)
reset=$(tput sgr0)
rc=0

if [ -z "$VIM_XML_RT" ]; then
  printf "\$VIM_XML_RT is not set, aborting!\n"
  exit 1;
fi

# needs to be run in the same subprocess, otherwise setting rc won't work
for i in */; do
  {
    cd "$i" &&
    test -f "cmd" && test -x "cmd" &&
    ./cmd
    diff -qu output.xml  reference.xml >/dev/null
    if [ $? -ne 0 ]; then
      printf "Test %s:\t\t[${red}Failed${reset}]\n" ${i%%/}
			if [ -n "$VERBOSE" ] || ( [ -n "$1" ] && [ "${1}" = "-v" ] ); then
        diff -u output.xml reference.xml
      fi
      rc=1
    else
      printf "Test %s:\t\t[${green}OK${reset}]\n" ${i%%/}
    fi
    cd "$OLDPWD"
    }
done
exit $rc
