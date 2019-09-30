#!/bin/sh

#set -x

# Setup some color variables
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setaf 4)
reset=$(tput sgr0)
rc=0
dir=$PWD

# needs to be run in the same subprocess, otherwise setting rc won't work
for i in */; do
  {
    printf "\n${blue}%s tests${reset}\n============\n" ${i%%/}
    test -f ${i}/test.sh && cd "$i" && ./test.sh; rc=$?; cd ..
    if [ $rc -ne 0 ]; then
      exit $rc;
    fi
  }
done
cd $dir
