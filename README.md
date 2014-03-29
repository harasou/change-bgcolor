bgchange
========

## bgchange とは

iTerm2 で ssh する際、接続先ごとにバックグランドカラーが設定できるラッパースクリプト。

## セットアップ

1. 適当なディレクトリに git clone

  ```
  git clone git@github.com:harasou/bgchange.git
  ```
1. alias を設定

  ```
  alias ssh='<cloneしたディレクトリ>/bgchange/ssh.sh'
  ```
1. 環境変数の定義

  ```
  export ITERM_BGCOLOR_1="{1000,0,1000}    localhost"
  ```
  - `ITERM_BGCOLOR_xxx` の形式で定義。複数設定可。
  - 第１パラメータ：設定したい色(下記補足のcheck_bgcolorで確認)
  - 第２パラメータ：接続先にマッチさせる bash の正規表現

  ```
  ### 例

  # 接続先が 192.168.0.0/24 の場合に、バックグラウンドを黒{0,0,0}にする
  # ex) ssh 192.168.0.1
  export ITERM_BGCOLOR_1="{0,0,0} ^192\.168\."

  # 接続のドメインが hoge.com の場合に、バックグラウンドカラーを白{65535,65535,65535}にする
  # ex) ssh www.hoge.com
  export ITERM_BGCOLOR_2="{65535,65535,65535} hoge\.com$"

  # 接続が hoge.com の DBサーバに、バックグラウンドカラーを青{0,0,65535}にする
  # ex) ssh db01.hoge.com
  export ITERM_BGCOLOR_3="{0,0,65535} ^db[0-9]+\.hoge\.com$"
  ```

## 使い方

普通に ssh コマンドを実行するだけ。接続が切れるともとの色に戻る。

```
ssh localhost
```

＠マークでユーザ名を指定した場合は、＠マーク以降の接続先が、第２パラメータの対象になる。

```
ssh -i $HOME/.ssh/id_rsa_harasou harasou@localhost
```

## 補足
- ssh の command 指定は未対応です。:sweat:

   ```
   ssh www.hoge.com hostname
   ```
- バックグラウンドに指定する数値は、リポジトリ内にある`check_bgcolor`コマンドで確認できます。

   ```
   # iTerm2 のプロファイル設定で、好みの色にした状態で、コマンドを実行
   ./check_bgcolor
   {0,65535,0}
   ```

