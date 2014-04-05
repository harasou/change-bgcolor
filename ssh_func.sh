#!/bin/bash

# iTerm で実行されたコマンドかチェック
is_iterm(){
    env | grep -qw ITERM_SESSION_ID
}

# 環境変数から引数(ホスト名)に対応するバックグランドカラーを取得
env_iterm_bgcolor(){

    local ENV_PREFIX="ITERM_BGCOLOR_"
    local line host=$1

    while read line
    do
        if [[ $line =~ ({[0-9 ]+,[0-9 ]+,[0-9 ]+})[[:space:]]+([^[:space:]]+) ]] ; then
            color=${BASH_REMATCH[1]}
            regex=${BASH_REMATCH[2]}

            [[ $host =~ $regex ]] && { echo $color ; return 0 ; }
        fi
    done < <(env|grep "^$ENV_PREFIX"|sed -e 's/^[^=]*=//' -e 's/\\/\\\\/g')

    return 1
}


# iTerm のバックグラウンドカラー変更処理
change_iterm_bgcolor(){

    [[ "$1" =~ {[0-9,\ ]+} ]] || return

    local curr_tty=$(tty)

    cat<<-EOC|/usr/bin/osascript
    tell application "iTerm"
      repeat with term in terminals
        repeat with sess in sessions of term
          if tty of sess is "$curr_tty" then
            set prev_color to background color of sess
            set background color of sess to $1
            return prev_color
          end if
        end repeat
      end repeat
    end tell
	EOC
}
