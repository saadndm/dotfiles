#!/usr/bin/env sh
set -e

multiple="$1"
directory="$2"
save="$3"
path="$4"
out="$5"
cmd="yazi"
termcmd="${TERMCMD}"

if [ "$save" = 1 ]; then
  set -- --chooser-file="$out" "$path"
elif [ "$directory" = 1 ]; then
  set -- --chooser-file="$out" --cwd-file="$out" "$path"
else
  set -- --chooser-file="$out" "$path"
fi

exec $termcmd "$cmd" "$@"
