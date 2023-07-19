# StartupLoader

<!-- [![GitHub release (latest by date)](https://img.shields.io/github/v/release/imaoki/StartupLoader)](https://github.com/imaoki/StartupLoader/releases/latest) -->
[![GitHub](https://img.shields.io/github/license/imaoki/StartupLoader)](https://github.com/imaoki/StartupLoader/blob/main/LICENSE)

スタートアップスクリプトを管理する。
<!-- Manage startup scripts. -->

## ライセンス
<!-- ## License -->

[MIT License](https://github.com/imaoki/StartupLoader/blob/main/LICENSE)

## 開発環境
<!-- ## Development Environment -->

`3ds Max 2024`

## インストール
<!-- ## Install -->

`install.ms`を実行する。
<!-- Execute `install.ms`. -->

## アンインストール
<!-- ## Uninstall -->

`uninstall.ms`を実行する。
<!-- Execute `uninstall.ms`. -->

## 単一ファイル版
<!-- ## Single File Version -->

### インストール
<!-- ### Install -->

`Distribution\StartupLoader.min.ms`を実行する。
<!-- Execute `Distribution\StartupLoader.min.ms`. -->

### アンインストール
<!-- ### Uninstall -->

```maxscript
::startupLoader.Uninstall()
```

## 使い方
<!-- ## Usage -->

### スクリプトファイルを登録する
<!-- ### Register script file -->

```maxscript
if isProperty ::startupLoader "RegisterFile" do (
  ::startupLoader.RegisterFile (getSourceFileName())
)
```

#### インストーラとして評価する
<!-- #### Evaluate as installer -->

```maxscript
if isProperty ::startupLoader "RegisterFile" do (
  ::startupLoader.RegisterFile (getSourceFileName()) installer:true
)
```

#### インストーラとして評価するための条件
<!-- #### Conditions for evaluation as installer -->

* スクリプトファイルの評価結果が構造体定義であること。
  <!-- * The result of the evaluation of the script file must be a structure definition. -->

* 引数を持たない静的メソッド`Install`を持っていること。
  <!-- * Must have a static method `Install` with no arguments. -->

### スクリプトファイルを登録解除する
<!-- ### Unregister script file -->

```maxscript
if isProperty ::startupLoader "UnregisterFile" do (
  ::startupLoader.UnregisterFile (getSourceFileName())
)
```

* `UnregisterFile`メソッドの引数には登録時と同じファイルパスを渡す。
  <!-- * The argument of the `UnregisterFile` method is the same file path as at the time of registration. -->

### スタートアップスクリプトの保存
<!-- ### Save Startup Script -->

```maxscript
::startupLoader.Write()
```

## 既定のスタートアップファイルの保存先
<!-- ## Default startup file location -->

`C:\Users\<UserName>\AppData\Local\Autodesk\3dsMax\<Version>\ENU\scripts\startup\StartupLoader.ms`
