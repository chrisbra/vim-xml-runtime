#!/bin/sh

#set -x

# Setup some color variables
red=
green=
blue=
yellow=
reset=

if [ -n "$TERM" ];  then
	red=$(tput setaf 1)
	green=$(tput setaf 2)
	blue=$(tput setaf 4)
	yellow=$(tput setaf 3)
	reset=$(tput sgr0)
else
	# make sure failing tests will output a diff on CI
	export VERBOSE=1
fi
export VIM_DEFAULT_ARG="--clean --not-a-term -N"

export red
export green
export blue
export yellow
export reset

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
