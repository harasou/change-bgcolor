change-bgcolor
========

## change-bgcolor とは

iTerm2 で ssh する際、接続先ごとにバックグランドカラーが設定できるラッパースクリプト。

## セットアップ

1. 適当なディレクトリに git clone

  ```
  git clone git@github.com:harasou/change-bgcolor.git
  ```
1. alias を設定

  ```
  alias ssh='<cloneしたディレクトリ>/change-bgcolor/ssh.sh'
  ```
1. 環境変数の定義

  ```
  export ITERM_BGCOLOR_1="{1000,0,1000}    localhost"
  ```
  - `ITERM_BGCOLOR_xxx` の形式で定義。複数設定可。
  - 第１パラメータ：設定したい色([補足](#補足)のcheck_bgcolorで確認可)
  - 第２パラメータ：接続先にマッチさせる bash の正規表現

  ```
  ### 例

  # 接続先が 192.168.0.0/24 の場合に、バックグラウンドを黒{0,0,0}にする
  # ex) ssh 192.168.0.1
  export ITERM_BGCOLOR_1="{0,0,0} ^192\.168\.0\."

  # 接続先のドメインが hoge.com の場合に、バックグラウンドカラーを白{65535,65535,65535}にする
  # ex) ssh www.hoge.com
  export ITERM_BGCOLOR_2="{65535,65535,65535} hoge\.com$"

  # 接続先が hoge.com の DBサーバの場合に、バックグラウンドカラーを青{0,0,65535}にする
  # ex) ssh db01.hoge.com
  export ITERM_BGCOLOR_3="{0,0,65535} ^db[0-9]+\.hoge\.com$"
  ```

## 使い方

普通に ssh コマンドを実行するだけ。接続が切れると、元の色に戻る。

```
ssh localhost
```

＠マークでユーザ名を指定した場合、＠マーク以降の接続先(localhost)が、
環境変数「ITERM_BGCOLOR_xxx」の第２パラメータの対象になる。

```
ssh harasou@localhost
```

もちろん、接続先以外のオプションも指定可能([補足あり](#補足))。

```
ssh -l harasou -i $HOME/.ssh/id_rsa_harasou www.hoge.com
```


## 補足
- ssh の command 指定は未対応です(ホスト名を最後の引数から拾っているため):sweat:

   ```
   ssh www.hoge.com hostname
   ```
- 環境変数「ITERM_BGCOLOR_xxx」の第２パラメータに設定する数値は、
  リポジトリ内にある`check_bgcolor`コマンドで確認できます。

   ```
   # iTerm2 のプロファイル設定で、好みの色にした状態で、コマンドを実行
   # 現在のバックグラウンドカラーの値が出力される。
   ./check_bgcolor
   {0,65535,0}
   ```

