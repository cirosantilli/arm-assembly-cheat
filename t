#!/usr/bin/env bash
action=test
gdb_break=
OPTIND=1
while getopts b:g OPT; do
  case "$OPT" in
    b)
      gdb_break="$OPTARG"
      ;;
    g)
      action=gdb
      ;;
  esac
done
shift "$(($OPTIND - 1))"
target="${1%%.*}"
if [ -n "$gdb_break" ]; then
  gdb_break_cmd="GDB_BREAK=${gdb_break}"
else
  gdb_break_cmd=
fi
make $gdb_break_cmd "${action}-${target}"
