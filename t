#!/usr/bin/env bash
action=test
while getopts g OPT; do
  case "$OPT" in
    g)
      action=gdb
      ;;
  esac
done
shift "$(($OPTIND - 1))"
target="${1%%.*}"
make "${action}-${target}"
