# StartupLoader

スタートアップスクリプトを管理する。

## 動作確認

`3ds Max 2022.3 Update`

## インストール

`install.ms`を実行する。

## アンインストール

`uninstall.ms`を実行する。

## スタンドアローン版

### インストール

`Distribution\StartupLoader.min.ms`を実行する。

### アンインストール

```maxscript
::startupLoader.Uninstall()
```

## 使い方

### スクリプトファイルをスタートアップに登録する

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

登録したスクリプトファイルをインストーラとして評価するには以下の条件を満たす必要がある。

* スクリプトファイルの評価結果が構造体定義であること。

* 引数を持たない静的メソッド`Install`を持っていること。

### スタートアップからスクリプトファイルを登録解除する

```maxscript
if isProperty ::startupLoader "UnregisterFile" do (
  ::startupLoader.UnregisterFile (getSourceFileName())
)
```

* `UnregisterFile`メソッドの引数には登録時と同じファイルパスを渡す。

### スタートアップスクリプトの保存

```maxscript
::startupLoader.Save()
```

## 補足情報

### 既定のスタートアップファイルの保存先

`C:\Users\ユーザー名\AppData\Local\Autodesk\3dsMax\バージョン\ENU\scripts\startup\StartupLoader.ms`

## ライセンス

[MIT License](https://github.com/imaoki/StartupLoader/blob/main/LICENSE)
