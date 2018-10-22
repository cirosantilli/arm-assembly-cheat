#!/usr/bin/env bash
action=test
gdb_break=
gdb_expert=n
OPTIND=1
while getopts b:c:Gg OPT; do
  case "$OPT" in
    b)
      gdb_break="$OPTARG"
      ;;
    c)
      cflags_cli="$OPTARG"
      ;;
    g)
      action=gdb
      ;;
    G)
      action=gdb
      gdb_expert=y
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
make $gdb_break_cmd CFLAGS_CLI="$cflags_cli" GDB_EXPERT="$gdb_expert" "${action}-${target}"
