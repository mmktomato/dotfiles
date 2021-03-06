# 移動系
* `:{num}` {num}行目に移動。
* `zt` カーソルのある行を画面の一番上にする。
* `zz` カーソルのある行を画面の中央にする。
* `zb` カーソルのある行を画面の一番下にする。
* `f{char}` カーソルのある行で{char}を検索。
* `F{char}` カーソルのある行で{char}を検索(逆方向)。
* `;` 直前の f または F を繰り返す。
* `,` 直前の f または F を繰り返す(逆方向)。
* `g;` 変更リストを辿る(新→旧)。
* `g,` 変更リストを辿る(旧→新)。
* `Ctrl-o` ジャンプリストを辿る(新→旧)。
* `Ctrl-i` ジャンプリストを辿る(旧→新)。

# 開始・終了
* `:cq` non-zero コードで vim を終了。

# 開く
* `gf` カーソル下のファイルを開く
* `Ctrl-w f` カーソル下のファイルをタブで開く
* `:vsplit :terminal ++curwin` 縦分割してターミナルをひらく

# 検索・置換
* `:%s/.../.../gc` 確認しながら置換。
* `/hoge で検索してから :%s//fuga/g` hoge を fuga に置換 (事前検索)。

# diff
* `:diffsplit {file, #bufnum}` 横に分割して diff モード。
* `:vertical diffsplit {file, #bufnum}` 縦に分割して diff モード。
* `:diffoff` diff モードを終了。
* `:diffthis` カレントのバッファを diff の対象にする。
* `(diff mode) ]c` 次の差分へ移動。
* `(diff mode) [c` 前の差分へ移動。

# タブ・ウィンドウ
* `gt, gT` タブ移動。
* `Ctrl-W x` 分割したウィンドウを入れ替える。
* `Ctrl-W H,J,K,L` 現在のウィンドウを(左,下,上,右)へ移動。
* `Ctrl-^` 代替ファイルを現在のウィンドウに表示。
* `Ctrl-W =` 分割したウィンドウの幅を揃える。

# Readonly
* `:set ro` バッファを readonly にする。
* `:set noro` バッファの readonly を解除する。
* `:view {file}` readonly でファイルを開く。
* `:sv {file}` `:sview {file}` ウィンドウを分割して readonly でファイルを開く。
* `:tabe sview {file}`        | 新しいタブで readonly でファイルを開く。

# ヤンク・ペースト
* `"ayy` レジスタ a に現在行をヤンク。
* `"ap` レジスタ a の内容をペースト。

# キーバインド
* `:help index.txt` デフォルトのキーバインド一覧を表示。
* `:map` vimrc に自分で設定、またはプラグインで設定されたキーバインド一覧を表示。

# Misc
* `:w !{コマンド}` バッファの内容を標準入力に流す。(ex. :w !wc -l)
* `:r {file}` {file} の内容をカーソル位置に挿入。
* `:r! {コマンド}` {コマンド} の結果をカーソル位置に挿入。
* `Ctrl-v Ctrl-m` コマンドモードで改行を入力。
