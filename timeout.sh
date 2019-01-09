#!/usr/bin/env bash

{ [[ $# == 0 ]] || [[ $# == 1 ]] || [[ $1 == '-h' ]] || [[ $1 == '-help' ]] || [[ $1 == '--help' ]]; } && echo "$0 "'DURATION COMMAND [ARG]...' && exit 1

function main() {
	local DURATION="$1"
	shift 1
	"$@" &
	local PID=$!
	local MYPID=$$

	if [[ $(uname -a) =~ Ubuntu ]]; then
		trap "env kill -0 $PID && env kill -TERM -- $PID; exit 1" 1 2 3 15
	else
		trap "kill -0 $MYPID && kill -TERM -- -$MYPID;    exit 1" 1 2 3 15
	fi

	sleep $DURATION

	# NOTE: below 'env' avoid to use shell builtin kill command
	# NOTE: ubuntu OK
	if [[ $(uname -a) =~ Ubuntu ]]; then
		env kill -0 $PID && env kill -TERM -- $PID
	else
		# NOTE: darwin(mac), yocto OK
		kill -0 $MYPID && kill -TERM -- -$MYPID
	fi

	wait
}

main "$@"
