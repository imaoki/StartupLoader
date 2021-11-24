# StartupScriptLoader

スタートアップスクリプトを管理する。

## インストール

`install.ms`を実行する。

## アンインストール

`uninstall.ms`を実行する。

## スクリプトをスタートアップに登録する

スクリプトの起動処理の最後に以下のコードを配置する。

```maxscript
if isProperty ::startupScriptLoader "RegisterScript" do (
  ::startupScriptLoader.RegisterScript (getSourceFileName())
  ::startupScriptLoader.Save()
)
```

## スクリプトをスタートアップから登録解除する

スクリプトの終了処理の最後に以下のコードを配置する。
`UnregisterScript`メソッドの引数には登録時のファイルパスを渡す。

```maxscript
if isProperty ::startupScriptLoader "UnregisterScript" do (
  ::startupScriptLoader.UnregisterScript (getSourceFileName())
  ::startupScriptLoader.Save()
)
```

## スタートアップファイルの保存先

`C:\Users\ユーザー名\AppData\Local\Autodesk\3dsMax\2021 - 64bit\ENU\scripts\startup\StartupScriptLoader.ms`

## ライセンス

[MIT License](https://github.com/imaoki/StartupScriptLoader/blob/main/LICENSE)
