# StartupScriptLoader

スタートアップスクリプトを管理する。

## 動作確認

`3ds Max 2022.3 Update`

## インストール

`install.ms`を実行する。

## アンインストール

`uninstall.ms`を実行する。

## 使い方

### スクリプトをスタートアップに登録する

以下のコードをスタートアップ時に実行したいスクリプトファイルの任意の位置に挿入する。

```maxscript
if isProperty ::startupScriptLoader "RegisterScript" do (
  ::startupScriptLoader.RegisterScript (getSourceFileName())
  ::startupScriptLoader.Save()
)
```

### スタートアップからスクリプトを登録解除する

以下のコードを登録解除用のスクリプトファイルの任意の位置に挿入する。
`UnregisterScript`メソッドの引数には登録時のファイルパスを渡す。

```maxscript
if isProperty ::startupScriptLoader "UnregisterScript" do (
  local registerFile = substituteString (getSourceFileName()) "unregister.ms" "register.ms"
  ::startupScriptLoader.UnregisterScript registerFile
  ::startupScriptLoader.Save()
)
```

## 既定のスタートアップファイルの保存先

`C:\Users\ユーザー名\AppData\Local\Autodesk\3dsMax\バージョン\ENU\scripts\startup\StartupScriptLoader.ms`

## ライセンス

[MIT License](https://github.com/imaoki/StartupScriptLoader/blob/main/LICENSE)
