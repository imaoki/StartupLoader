# StartupLoader

<!-- [![GitHub release (latest by date)](https://img.shields.io/github/v/release/imaoki/StartupLoader)](https://github.com/imaoki/StartupLoader/releases/latest) -->
[![GitHub](https://img.shields.io/github/license/imaoki/StartupLoader)](https://github.com/imaoki/StartupLoader/blob/main/LICENSE)

スタートアップスクリプトを管理する。

## ライセンス

[MIT License](https://github.com/imaoki/StartupLoader/blob/main/LICENSE)

## 開発環境

`3ds Max 2024`

## インストール

`install.ms`を実行する。

## アンインストール

`uninstall.ms`を実行する。

## 単一ファイル版

### インストール

`Distribution\StartupLoader.min.ms`を実行する。

### アンインストール

```maxscript
::startupLoader.Uninstall()
```

## 使い方

### スクリプトファイルを登録する

```maxscript
if isProperty ::startupLoader "RegisterFile" do (
  ::startupLoader.RegisterFile (getSourceFileName())
)
```

#### インストーラとして評価する

```maxscript
if isProperty ::startupLoader "RegisterFile" do (
  ::startupLoader.RegisterFile (getSourceFileName()) installer:true
)
```

#### インストーラとして評価するための条件

* スクリプトファイルの評価結果が構造体定義であること。

* 引数を持たない静的メソッド`Install`を持っていること。

### スクリプトファイルを登録解除する

```maxscript
if isProperty ::startupLoader "UnregisterFile" do (
  ::startupLoader.UnregisterFile (getSourceFileName())
)
```

* `UnregisterFile`メソッドの引数には登録時と同じファイルパスを渡す。

### スタートアップスクリプトの保存

```maxscript
::startupLoader.Write()
```

## 既定のスタートアップファイルの保存先

`C:\Users\<UserName>\AppData\Local\Autodesk\3dsMax\<Version>\ENU\scripts\startup\StartupLoader.ms`
