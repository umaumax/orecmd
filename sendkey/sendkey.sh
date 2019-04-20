#!/usr/bin/env bash
main() {
  [[ $# -lt 1 ]] && echo "$(basename "$0") <host> [default key]" && return 1
  local host="$1"
  local default_key="${2:-c}"
  echo "Please put a key and Enter!"
  echo "e.g. Shift_L, Return, Dollar Left, Up, Right, Down, Space, a~z, A~Z"
  cat | while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z $line ]] && line="$default_key"
    echo "$line"
  done | ssh "$host" 'export DISPLAY=:0;' \
    'while IFS= read -r line || [[ -n "$line" ]]; do' \
    'xdotool key "$line";' \
    'done'
}

main "$@"
