#!/bin/bash

SCRIPT_DIR=$(cd `dirname $0`;pwd)
. "$SCRIPT_DIR/ssh_func.sh"

cleanup(){
    if [ -n "$prev_bgcolor" ] ; then
        change_iterm_bgcolor "{$prev_bgcolor}" >/dev/null
    fi
}
trap cleanup 1 2 3 15

if is_iterm ; then
  
    # ホスト名の後に command が指定されている場合は
    # バグります :-p
    host=$(echo $(eval echo \${$#}))
    host=${host#*@}

    if bgcolor=$(env_iterm_bgcolor $host) ; then
        prev_bgcolor=$(change_iterm_bgcolor $bgcolor)
    fi
fi

\ssh ${@+"$@"}
ret=$?

cleanup

exit $ret
